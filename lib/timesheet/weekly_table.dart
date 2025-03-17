import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:timesheet_management/timesheet/day_timesheet.dart';
import 'package:timesheet_management/utils/api/post_api.dart';
import 'package:timesheet_management/utils/static_data/motows_colors.dart';

import '../utils/api/get_api.dart';
import '../utils/custom_popup_dropdown/custom_popup_dropdown.dart';
import '../utils/functions/data_functions.dart';


class WeeklyExpandableTable extends StatefulWidget {
  final Function(String) onTotalHoursUpdated;
  final List weekDays;
  const WeeklyExpandableTable({super.key, required this.onTotalHoursUpdated, required this.weekDays});

  @override
  State<WeeklyExpandableTable> createState() => _WeeklyExpandableTableState();
}

class _WeeklyExpandableTableState extends State<WeeklyExpandableTable> {
  List<Employee> employees = [];

  List projectData =[
    {"projectName":"Proj123","projectID":"23342"},
    {"projectName":"Pro300","projectID":"11232"},
    {"projectName":"Pro3001","projectID":"00232"}
  ];

  List weekDays =[];
  DateTime selectedMonths = DateTime.now();
  int? selectedWeek;
  List weeks = [];
  List daysInWeek =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weekDays= widget.weekDays;
    getInitialData();
  }

  Future<void> _selectMonth(BuildContext context) async {
    DateTime? picked =  await showMonthPicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(2050)
    );

    if (picked != null && picked != selectedMonths) {
      selectedMonths =picked;
      weeks.clear();
      var weeksOfMonth =getAllWeeksOfMonth(picked);
      daysInWeek= weeksOfMonth;
      for (int i = 0; i < weeksOfMonth.length; i++) {
        weeks.add(i);

      }
      // for(int i=0;i<totalWeeks;i++){
      //   weeks.add(i);
      // }
      setState(() {

        selectedWeek = null;
        // generateWeeks();
      });
    }
  }

  List getAllWeeksOfMonth(DateTime selectedDate) {
    DateTime firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime lastDayOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);

    // Find the first Monday of the month (Adjust to Sunday if needed)
    DateTime firstMonday = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday ));

    List weeks = [];
    DateTime currentWeekStart = firstMonday;
    while (currentWeekStart.isBefore(lastDayOfMonth) || currentWeekStart.isAtSameMomentAs(lastDayOfMonth)) {
      List week = [];

      for (int i = 0; i < 7; i++) {
        DateTime currentDate = currentWeekStart.add(Duration(days: i));
        if (currentDate.month == selectedDate.month) {
          week.add(DateFormat('dd-MM-yyyy').format(currentDate));
        }
      }
      if(week.isNotEmpty) {
        weeks.add(week);
      }
      currentWeekStart = currentWeekStart.add(const Duration(days: 7));
    }

    return weeks;
  }
  getInitialData() async {
    weeks=[];
    daysInWeek = getAllWeeksOfMonth(selectedMonths);
    for (int i = 0; i < daysInWeek.length; i++) {

      weeks.add(i);
      // "Week ${i + 1}: ${weeksOfMonth[i].map((d) => d.toString().split(' ')[0]).toList()}");
    }
    // Get today's date
    DateTime today = selectedMonths;

    // Format date as dd-MM-yyyy
    String todayStr = "${today.day.toString().padLeft(2, '0')}-"
        "${today.month.toString().padLeft(2, '0')}-"
        "${today.year}";

    // Find the index of the week containing today's date
    selectedWeek = daysInWeek.indexWhere((week) => week.contains(todayStr));

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
        try{
          return sum + int.parse(parts[0]) * 60 + int.parse(parts[1]);
        }
        catch(e){
          return 0;
        }

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
  void didUpdateWidget(covariant WeeklyExpandableTable oldWidget) {

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
            const SizedBox(height: 20,),
            Container(height: 130,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width:40,),
                    InkWell(
                      onTap: () => _selectMonth(context),
                      child: Row(
                        children: [

                          FloatingActionButton(
                            onPressed: () {
                              _selectMonth(context);
                            },
                            child: const Icon(Icons.calendar_today),
                          ),
                          const SizedBox(width: 10,),
                          Text(DateFormat('MMMM').format(selectedMonths),style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                // Week Selection
                if (weeks.isNotEmpty)
                  Row(
                    children: [
                      const SizedBox(width: 20,),
                      Wrap(
                        spacing: 12, // Slightly increased spacing
                        runSpacing: 8, // Add vertical spacing
                        children: List.generate(weeks.length, (index) {
                          bool isSelected = selectedWeek == index;
                          return ChoiceChip(
                            label: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // More padding for better touch area
                              child: Text(
                                'Week ${index + 1}',
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: Colors.blue,
                            backgroundColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Smooth rounded edges
                              side: BorderSide(color: isSelected ? Colors.blue : Colors.grey.shade400),
                            ),
                            elevation: isSelected ? 4 : 0, // Adds depth effect when selected
                            onSelected: (value) {
                              weekDays = daysInWeek[index];
                              getInitialData();
                              setState(() => selectedWeek = index);
                            },
                          );
                        }),
                      ),
                    ],
                  ),


                const SizedBox(height: 16),

              ],
            ),
            ),
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
                                window.sessionStorage["userType"]=="Approver" && (sub.status=="Pending") ? Row(
                                  children: [
                                    Tooltip(message: "Approve",child: SizedBox(width: 30,child:  Center(child: InkWell(child: const Icon(Icons.check_circle_sharp,color: Colors.green),onTap: (){
                                      _showConfirmationDialog(context, "Approve", "Are you sure you want to approve?");

                                    })),)),
                                    const SizedBox(width: 20),
                                    Tooltip(message: "Reject",child: SizedBox(width: 20,child:  Center(child: InkWell(child: const Icon(Icons.cancel_outlined,color: Colors.red),onTap: (){
                                      _showConfirmationDialog(context, "Reject", "Are you sure you want to reject?");

                                    })),)),
                                  ],
                                ):
                                sub.status==""? Padding(
                                    padding: const EdgeInsets.only(right: 0.0),
                                    child: ElevatedButton(
                                      onPressed: () {
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

                                        // postTimeSheet(tempList);

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

  void _showConfirmationDialog(BuildContext context, String action, String message) {
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
                          onPressed: () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("$action successful")),
                            );
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
    String url = "https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/timesheet/add_timesheet";

   var response = await postData(url: url,requestBody: tempJson,context: context);

    if (response != null) {

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




