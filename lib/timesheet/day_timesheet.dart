import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:timesheet_management/utils/api/post_api.dart';
import 'package:timesheet_management/utils/static_data/motows_colors.dart';
import 'package:http/http.dart' as http;
import '../utils/api/get_api.dart';
import '../utils/custom_popup_dropdown/custom_popup_dropdown.dart';
import '../utils/functions/data_functions.dart';


class DayExpandableTable extends StatefulWidget {
  final Function(String) onTotalHoursUpdated;
  final String today;
  final String? userId;
  const DayExpandableTable({super.key, required this.onTotalHoursUpdated, required this.today, this.userId});

  @override
  State<DayExpandableTable> createState() => _DayExpandableTableState();
}

class _DayExpandableTableState extends State<DayExpandableTable> {
  List<Employee> employees = [];

  List projectData =[];
  String userId="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var dateNow = DateTime.now();
    String date= "${dateNow.day}-${dateNow.month}-${dateNow.year}";
    userId = window.sessionStorage["userId"]??"";
    getInitialData(dateNow :date);
    getProjectList();
  }

  getInitialData({required String dateNow}) async {
     List responseData = await getTimeSheet(date: getDate(dateNow));
     if(responseData.isEmpty){
       employees=[];
       setState(() {
         employees.add(Employee(
           widget.today,
           "",
           "Pending",
           [
             SubRow("", "", "", "", "",""),
           ],
         ),);
       });
     }
     else
     {
       employees=[];
       for(int i=0;i<responseData.length;i++){
         List<SubRow> subList =[];
         for(int j =0;j<responseData[i]['timeSheet'].length;j++){
           subList.add(
             SubRow(responseData[i]['timeSheet'][j]['timesheet_id'],responseData[i]['timeSheet'][j]['project_name'], responseData[i]['timeSheet'][j]['project_id'], responseData[i]['timeSheet'][j]['wbs'], responseData[i]['timeSheet'][j]['daily_log'], responseData[i]['timeSheet'][j]['status']),
           );
         }
         employees.add(
           Employee(
             widget.today,
             "${responseData[i]['totalHrs']}",
             "Pending",
             subList,
           ),
         );
       }
     }

    setState(() {

    });
  }

  getTimeSheet({required String date}) async {
    String url ="https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/timesheet/get_timesheet_by_date/$userId/$date";
    List tempData = await  getData(context: context,url: url);
    // Group by date
    Map groupedByDate = {};
    for (var entry in tempData) {
      final date = entry['log_date']!;
      groupedByDate.putIfAbsent(date, () => []).add(entry);
    }

    // Build the final list
    List<Map> result = groupedByDate.entries.map((entry) {
      int totalMinutes = entry.value.fold(0, (sum, item) {
        final parts = item['daily_log']!.split(':');
        return sum + int.parse(parts[0]) * 60 + int.parse(parts[1]);
      });

      String totalHrs = '${(totalMinutes ~/ 60).toString().padLeft(2, '0')}:${(totalMinutes % 60).toString().padLeft(2, '0')}';

      return {
        "totalHrs": totalHrs,
        "date": entry.key,
        "timeSheet": entry.value
      };
    }).toList();
    print(result);
    if(result.isNotEmpty) {
      widget.onTotalHoursUpdated(result[0]['totalHrs']);
    }
    else{
      widget.onTotalHoursUpdated("0:00");
    }
    return result;

  }

  getProjectList() async{
    String url = "https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/projectcreation/get_all_Projects_By_user_id/${window.sessionStorage["userId"]}";
    var response = await getData(context: context,url: url);
    if (response != null) {
      projectData = response;
      setState(() {

      });
    } else {
      print('---- Failed to fetch project list ----');
    }
  }

  getProjectWBSbyProjectName(String projectName) async{
    String url = "https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/wbs/get_WbsNames_by_project_name/$projectName";
    var response = await getData(context: context,url: url);
    if (response != null) {
      return response;
      setState(() {

      });
    } else {
      print('---- Failed to fetch project list ----');
    }
  }




  @override
  void didUpdateWidget(covariant DayExpandableTable oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if(widget.userId!=null){
      userId = widget.userId!;
    }
    if(widget.userId != oldWidget.userId) {
      employees=[];
      getInitialData(dateNow: widget.today);
    }
    else if (widget.today != oldWidget.today && oldWidget.today!=""){
      employees=[];
      getInitialData(dateNow: widget.today);
    }

  }


  List wbsList =[];
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 30,),
            Container(decoration: BoxDecoration(color: Colors.grey[300]),
              child: ExpansionTile(
                title: DataTable(
                    headingTextStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                    columnSpacing: 10, // Adjust column spacing
                    dataRowMinHeight: 20, // Minimum row height
                    dataRowMaxHeight: 20, // Maximum row height
                    headingRowHeight: 20, // Reduce the height of column headers
                    columns:  const [
                      DataColumn(label: SizedBox(width: 250,child: Text("Project Name",),),),
                      DataColumn(label: SizedBox(width: 100,child: Text("Project ID",))),
                      DataColumn(label: SizedBox(width: 100,child:Text("WBS",))),
                      DataColumn(label: SizedBox(width: 100,child:Text("Daily Log",))),
                      DataColumn(label: SizedBox(width: 100,child:Text("Approval Status",))),
                    ],
                    rows: const []
                ),
                trailing: const SizedBox(),
              ),
            ),
            SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                children: employees.map((employee) {

                  return ExpansionTile(initiallyExpanded: true,
                    title: DataTable(
                      columnSpacing: 10,
                      dataRowMinHeight: 30,
                      dataRowMaxHeight: 35,
                      headingRowHeight: 30,
                      headingRowColor: MaterialStateProperty.all(Colors.blue[50]),

                      columns: [
                        DataColumn(label: SizedBox(width: 250, child:  Padding(
                            padding: const EdgeInsets.only(right: 0.0),
                            child: Row(
                              children: [
                                SizedBox(width: 100,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(employee.subRows.last.timeSheetId!="" && employee.subRows.last.wbs!="")
                                      {
                                        employee.subRows.add( SubRow("","", "", "","",""),);
                                        setState(() {

                                        });
                                      }
                                      else{

                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 4,
                                    ),

                                    child: const Text('Add', style: TextStyle(color: Colors.white, fontSize: 16)),
                                  ),
                                ),
                              ],
                            )



                        ))),
                        DataColumn(label: SizedBox(width: 100, child: Text(employee.date,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),))),
                        const DataColumn(label: SizedBox(width: 100, child: Text(""))),
                        DataColumn(label: SizedBox(width: 100, child: Text(employee.logHrs,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),))),
                        const DataColumn(label: SizedBox(width: 100, child: Text(""))),
                      ],
                      rows: const [],
                    ),
                    children: employee.subRows.asMap().entries.map((entry) {
                      int index = entry.key;
                      var sub = entry.value;
                      final timeController = TextEditingController(text: sub.logHrs);
                      timeController.selection = TextSelection.fromPosition(TextPosition(offset: timeController.text.length));

                      return ExpansionTile(
                        title: DataTable(
                          columnSpacing: 10,
                          dataRowMinHeight: 25,
                          dataRowMaxHeight: 25,
                          headingRowHeight: 30,
                          columns: sub.status !="Completed" ?
                          [
                            DataColumn(
                              label: Container(
                                alignment: Alignment.topCenter,
                                color: Colors.lightBlueAccent[50],
                                width: 250,height: 24,
                                child: LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return CustomPopupMenuButton(
                                      elevation: 4,
                                      decoration: customPopupDecoration(hintText: sub.projectName,),
                                      itemBuilder: (
                                          BuildContext context) {
                                        return projectData.map((value) {
                                          return CustomPopupMenuItem(
                                              value: value,
                                              text: value['project_name'],
                                              child: Container()
                                          );
                                        }).toList();
                                      },
                                      onSelected: (value) async{
                                        value as Map;
                                       List wbsDataList = await getProjectWBSbyProjectName(value['project_name'].toString());
                                       wbsList= [];
                                       for(int i=0;i<wbsDataList.length;i++){
                                         wbsList.add(wbsDataList[i]['wbs_name']);
                                       }

                                        setState(() {
                                          employee.subRows[index].projectName=value['project_name'].toString();
                                          employee.subRows[index].projectId=value['project_id'].toString();
                                        });
                                      },
                                      onCanceled: () {

                                      },
                                      hintText: "",
                                      childWidth: constraints.maxWidth,
                                      child: Container(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            DataColumn(label: SizedBox(width: 100, child: Text(sub.projectId))),
                            DataColumn(
                              label: Container(
                                alignment: Alignment.topCenter,
                                color: Colors.lightBlueAccent[50],
                                width: 100,height: 24,
                                child: LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return CustomPopupMenuButton(
                                      elevation: 4,
                                      decoration: customPopupDecoration(hintText: sub.wbs,),
                                      itemBuilder: (
                                          BuildContext context) {
                                        return wbsList.map((value) {
                                          return CustomPopupMenuItem(
                                              value: value,
                                              text: value,
                                              child: Container()
                                          );
                                        }).toList();
                                      },
                                      onSelected: (value) async{

                                        setState(() {
                                          employee.subRows[index].wbs=value.toString();
                                        });
                                      },
                                      onCanceled: () {

                                      },
                                      hintText: "",
                                      childWidth: constraints.maxWidth,
                                      child: Container(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            DataColumn(
                                label: SizedBox(height: 30,
                                  width: 100, child: TextField(
                                    controller: timeController,
                                    keyboardType: TextInputType.number,style: const TextStyle(fontSize: 14),
                                    onChanged: (v){
                                      sub.logHrs=v;
                                      employee.logHrs=employee.calculateTotalLogHrs();
                                      widget.onTotalHoursUpdated(employee.calculateTotalHeaderHours(employees));
                                      setState(() {


                                      });
                                    },
                                    inputFormatters: [

                                      LengthLimitingTextInputFormatter(5), // Limit to 4 digits
                                      TimeInputFormatter(),
                                    ],
                                    decoration: const InputDecoration(
                                      // labelText: "Work Hours (HH:mm)",
                                      hintText: "00:00",contentPadding:  EdgeInsets.fromLTRB(0, 0, 0, 15),
                                      border: InputBorder.none,
                                    ),
                                  ),)),
                            DataColumn(
                                label: SizedBox(width: 100,
                                  child:
                                  window.sessionStorage["userType"]=="Manager" && (sub.status=="Pending") ? Row(
                                    children: [
                                      Tooltip(message: "Approve",child: SizedBox(width: 30,child:  Center(child: InkWell(child: const Icon(Icons.check_circle_sharp,color: Colors.green),onTap: (){
                                        _showConfirmationDialog(context, "Approve", "Are you sure you want to approve?",sub);

                                      })),)),
                                      const SizedBox(width: 20),
                                      Tooltip(message: "Reject",child: SizedBox(width: 20,child:  Center(child: InkWell(child: const Icon(Icons.cancel_outlined,color: Colors.red),onTap: (){
                                        _showConfirmationDialog(context, "Reject", "Are you sure you want to reject?",sub);

                                      })),)),
                                    ],
                                  ):
                                  sub.status==""? Padding(
                                      padding: const EdgeInsets.only(right: 0.0),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          Map tempJson =  {
                                            "daily_log":sub.logHrs,
                                            "log_date": getDate( widget.today),
                                            "project_id":  sub.projectId,
                                            "project_name": sub.projectName,
                                            "status": "pending",
                                            "user_id": window.sessionStorage["userId"],
                                            "wbs": sub.wbs,
                                          };
                                          print(tempJson);

                                          List tempList =[];
                                          tempList.add(tempJson);
                                          
                                          await postTimeSheet(tempList);
                                          var dateNow = DateTime.now();
                                          String date= "${dateNow.day}-${dateNow.month}-${dateNow.year}";
                                          await getInitialData(dateNow :date);

                                          setState(() {

                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          elevation: 4,
                                        ),

                                        child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 16)),
                                      )



                                  ):Text(
                                    sub.status,
                                    style: TextStyle(color: sub.status == "Completed" ? Colors.green : sub.status == "Pending" ? Colors.deepOrange : Colors.red),
                                  ),
                                    ),
                                  )
                                ]:[
                            DataColumn(label: SizedBox(width: 100, child: Text(sub.timeSheetId))),
                            DataColumn(label: SizedBox(width: 100, child: Text(sub.projectId))),
                            DataColumn(label: SizedBox(width: 100, child: Text(sub.wbs))),
                            DataColumn(label: SizedBox(width: 100, child: Text(sub.logHrs))),
                            DataColumn(label: SizedBox(width: 100,child: Text(sub.status,style: TextStyle(color: sub.status =="Completed"?Colors.green:sub.status =="Pending"?Colors.deepOrange:Colors.red),)
                            )
                            ),
                          ],
                          rows: const [],
                        ),
                        trailing: sub.status !="Approved" ?InkWell(
                          onTap: () async {
                            await deleteById (employee.subRows[index].timeSheetId);
                            setState(() {
                              employee.subRows.removeAt(index); // Remove the row
                            });
                          },
                          child: const Icon(Icons.delete, color: Colors.red),
                        ):const SizedBox(),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),

          ],
        ),
      ),
    );
  }
  void _showConfirmationDialog(BuildContext context, String action, String message, SubRow sub) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          child: SizedBox(width: 340,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    action == "Approve" ? Icons.check_circle : Icons.cancel,
                    size: 60,
                    color: action == "Approve" ? Colors.green : Colors.red,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "$action Confirmation",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: Text("Cancel", style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            Map tempJson = {
                              "status": action == "Approve" ?"Approved": "Rejected",
                            };
                            setState(() {
                              sub.status = action == "Approve" ?"Approved": "Rejected";
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$action successful")));

                            await updateStatus(id: sub.timeSheetId, requestBody:tempJson);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: action == "Approve" ? Colors.green : Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(action, style: const TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static customPopupDecoration({required String hintText}) {
    return InputDecoration(
      hoverColor: mHoverColor,
      disabledBorder:  InputBorder.none,
      suffixIcon: const Icon(Icons.arrow_drop_down_circle_sharp, color: mSaveButton, size: 14),
      border:  InputBorder.none,
      constraints: const BoxConstraints(maxHeight: 30),
      hintText: hintText=="" ?"Select":hintText ,
      hintStyle:  TextStyle(fontSize:hintText!='Select'?14: 12, color:hintText!='Select'? Colors.black:Colors.black54),
      counterText: '',
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 20),

    );
  }

  Future postTimeSheet(List tempJson) async {
    String url =
        "https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/timesheet/add_timesheet";
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
        body: json.encode(tempJson)
    );
    if (response.statusCode == 200) {
      print(response.body);
    }

    return [];
  }

  updateStatus({required String id, required Map<dynamic, dynamic> requestBody}) async{
    String url ="https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/timesheet/patch_timesheet/$id";
    var response = await updateData(url, requestBody);
    if(response!=null){
      print("Success");
    }
  }

   deleteById(String timeSheetId) async {
     String url ="https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/timesheet/delete_timesheet_by_id/$timeSheetId";
     var response = await deleteApi(url);
     if(response!=null){
       print("Success");
     }
   }

}

class Employee {
  String date;
  String logHrs;
  String status;
  List<SubRow> subRows;

  Employee(
      this.date,
      this.logHrs,
      this.status,
      this.subRows,
      );

  String calculateTotalLogHrs() {
    int totalMinutes = subRows.fold(
        0, (sum, subRow) => sum + _convertToMinutes(subRow.logHrs));
    return _convertToHoursMinutes(totalMinutes);
  }

  int _convertToMinutes(String logHrs) {
    try{
      List<String> parts = logHrs.split(":");
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);
      return (hours * 60) + minutes;
    }
    catch(e){
      return 0;
    }
  }

  String _convertToHoursMinutes(int totalMinutes) {
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;
    return "$hours:${minutes.toString().padLeft(2, '0')}";
  }

  String calculateTotalHeaderHours(List<Employee> employees) {
    try{
      int totalMinutes = employees.fold(0, (sum, emp) => sum + _convertToMinutes(emp.logHrs));
      return _convertToHoursMinutes(totalMinutes);
    }
    catch(e){

      return "0";
    }
  }
}

class SubRow {
  String timeSheetId;
  String projectName;
  String projectId;
  String wbs;
  String logHrs;
  String status;
  SubRow(this.timeSheetId,this.projectName,this.projectId,this.wbs, this.logHrs,this.status);
}


class TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newValue2 =newValue.text;
    if (newValue2.contains(':') && newValue2.length == 2) {
      newValue2 = '0$newValue2';
    }
    /// if new value contains ":" and length is 2 add 0 to prefix
    String text = newValue2.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.length > 2) {
      text = '${text.substring(0, 2)}:${text.substring(2)}';
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}