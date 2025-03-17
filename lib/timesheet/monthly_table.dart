import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:timesheet_management/timesheet/day_timesheet.dart';
import 'package:timesheet_management/utils/api/post_api.dart';
import 'package:timesheet_management/utils/static_data/motows_colors.dart';

import '../utils/api/get_api.dart';
import '../utils/custom_popup_dropdown/custom_popup_dropdown.dart';
import '../utils/functions/data_functions.dart';

class MonthlyTable extends StatefulWidget {
  final Function(String) onTotalHoursUpdated;
  final List weekDays;
  const MonthlyTable({super.key, required this.onTotalHoursUpdated, required this.weekDays});

  @override
  State<MonthlyTable> createState() => _MonthlyTableState();
}

class _MonthlyTableState extends State<MonthlyTable> {
  List<Employee> employees = [];

  List projectData =[
    {"projectName":"Proj123","projectID":"23342"},
    {"projectName":"Pro300","projectID":"11232"},
    {"projectName":"Pro3001","projectID":"00232"}
  ];

  List weekDays =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weekDays= widget.weekDays;
    getInitialData();
  }


  getInitialData() async {
    employees=[];
    for(int i=0;i<weekDays.length;i++){
      DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(weekDays[i]);

      // Format the parsed date to 'yyyy-MM-dd'
      String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);

      employees.add(Employee(
        formattedDate,
        "00:00",
        "Pending",
        [],
      ),);

    }

    List responseData = await getTimeSheet(fromDate: getDate(weekDays.first),toDate:getDate(weekDays.last));
    for(int i=0;i<responseData.length;i++){
      DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(responseData[i]['date']);

      // Format the parsed date to 'yyyy-MM-dd'
      String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
      responseData[i]['date'] = formattedDate;
      List<SubRow> subList =[];
      for(int j =0;j<responseData[i]['timeSheet'].length;j++){
        subList.add(
          SubRow(responseData[i]['timeSheet'][j]['timesheet_id'],responseData[i]['timeSheet'][j]['project_id'], responseData[i]['timeSheet'][j]['project_name'], responseData[i]['timeSheet'][j]['wbs'], responseData[i]['timeSheet'][j]['daily_log'], responseData[i]['timeSheet'][j]['status']),
        );
      }
      for(int k=0;k<employees.length;k++ ) {
        var tableData = employees[k];
        if(tableData.date == responseData[i]['date']){

          employees[k]= Employee(
            formattedDate,
            "${responseData[i]['totalHrs']}",
            "Pending",
            subList,
          );

        }
      }


    }



    setState(() {

    });
  }

  getTimeSheet({required fromDate, required toDate}) async {

    String url ="https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/timesheet/get_timesheet_by_userId_logDate/USER123/$fromDate/$toDate";
    // print(url);
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
    return result;
  }
  @override
  void didUpdateWidget(covariant MonthlyTable oldWidget) {

    super.didUpdateWidget(oldWidget);
    if (widget.weekDays != oldWidget.weekDays) {

      weekDays = widget.weekDays;
      employees = [];
      getInitialData();


    }
  }

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
                      DataColumn(label: SizedBox(width: 100,child: Text("Project ID",),),),
                      DataColumn(label: SizedBox(width: 100,child: Text("Project Name",))),
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
                  List wbsList =["WBS2","WBS33"];
                  return ExpansionTile(initiallyExpanded: true,
                    title: DataTable(
                      columnSpacing: 10,
                      dataRowMinHeight: 30,
                      dataRowMaxHeight: 35,
                      headingRowHeight: 30,
                      headingRowColor: MaterialStateProperty.all(Colors.blue[50]),

                      columns: [
                        DataColumn(label: SizedBox(width: 100, child:  Padding(
                            padding: const EdgeInsets.only(right: 0.0),
                            child: ElevatedButton(
                              onPressed: () {

                                employee.subRows.add( SubRow("","", "", "","",""),);
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

                              child: const Text('Add', style: TextStyle(color: Colors.white, fontSize: 16)),
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
                                width: 100,height: 24,
                                child: LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return CustomPopupMenuButton(
                                      elevation: 4,
                                      decoration: customPopupDecoration(hintText: sub.projectID,),
                                      itemBuilder: (
                                          BuildContext context) {
                                        return projectData.map((value) {
                                          return CustomPopupMenuItem(
                                              value: value,
                                              text: value['projectName'],
                                              child: Container()
                                          );
                                        }).toList();
                                      },
                                      onSelected: (value) {
                                        value as Map;
                                        setState(() {
                                          employee.subRows[index].projectID=value['projectID'].toString();
                                          employee.subRows[index].task=value['projectName'].toString();
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
                            DataColumn(label: SizedBox(width: 100, child: Text(sub.task))),
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
                                      onSelected: (value) {
                                        print(value);
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
                                child:sub.status==""? Padding(
                                    padding: const EdgeInsets.only(right: 0.0),
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        Map tempJson =  {
                                          "daily_log":sub.logHrs,
                                          "log_date": getDate(employee.date),
                                          "project_id":  sub.projectID,
                                          "project_name": sub.projectID,
                                          "status": "pending",
                                          "user_id": "USER123",
                                          "wbs": sub.wbs,
                                        };
                                        print(tempJson);

                                        List tempList =[];
                                        tempList.add(tempJson);

                                        await postTimeSheet(tempList);
                                        await getInitialData();

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
                            DataColumn(label: SizedBox(width: 100, child: Text(sub.projectID))),
                            DataColumn(label: SizedBox(width: 100, child: Text(sub.task))),
                            DataColumn(label: SizedBox(width: 100, child: Text(sub.wbs))),
                            DataColumn(label: SizedBox(width: 100, child: Text(sub.logHrs))),
                            DataColumn(label: SizedBox(width: 100,child: Text(sub.status,style: TextStyle(color: sub.status =="Completed"?Colors.green:sub.status =="Pending"?Colors.deepOrange:Colors.red),)
                            )
                            ),
                          ],
                          rows: const [],
                        ),
                        trailing: InkWell(
                          onTap: () {
                            setState(() {
                              print(employee.subRows[index].id);
                              // employee.subRows.removeAt(index); // Remove the row
                            });
                          },
                          child: const Icon(Icons.delete, color: Colors.red),
                        ),
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
    String url = "https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/timesheet/add_timesheet";
    print(url);
    var response = await postData(url: url,requestBody: tempJson,context: context);

    if (response != null) {
      print(response);
    }

    return [];
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
      return "";
    }
  }
}

class SubRow {
  String id;
  String projectID;
  String task;
  String wbs;
  String logHrs;
  String status;
  SubRow(this.id,this.projectID,this.task,this.wbs, this.logHrs,this.status);
}
