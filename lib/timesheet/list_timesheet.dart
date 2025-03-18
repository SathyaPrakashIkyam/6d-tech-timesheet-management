import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:timesheet_management/timesheet/day_timesheet.dart';
import 'package:timesheet_management/timesheet/weekly_table.dart';
import 'package:timesheet_management/utils/classes/arguments_classes.dart';
import 'package:timesheet_management/utils/customAppBar.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';

import '../utils/customDrawer.dart';
import '../utils/custom_popup_dropdown/custom_popup_dropdown.dart';
import '../utils/static_data/motows_colors.dart';
import 'monthly_table.dart';

class ListTimesheet extends StatefulWidget {
  final ListTimeSheetArguments args;
  const ListTimesheet({super.key, required this.args});

  @override
  State<ListTimesheet> createState() => _ListTimesheetState();
}

class _ListTimesheetState extends State<ListTimesheet> {

  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();
  List<bool> isSelected = [true, false, false];

  String totalHours = "8:00"; // Default value
  String selectedUser = "User 1"; // Default value
  TextEditingController totalHr = TextEditingController(text: "00:00");
  List weekDays =[];
  List monthDays =[];
  DateTime selectedMonth = DateTime.now();
  int? selectedWeek;
  List<List<DateTime>> weeks = [];
  final TextEditingController dateController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitialRecords();
    generateWeeks();
  }

  getInitialRecords(){
    DateTime today = DateTime.now();
    weekDays = getWeekDays(today);
    monthDays = getMonthDaysTillToday(today);
    dateController.text =DateFormat('dd-MM-yyyy').format(today);
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const PreferredSize(    preferredSize: Size.fromHeight(60),
          child: CustomAppBar()),
      drawer: const AppBarDrawer(drawerWidth: 200,selectedDestination: 3),
      body: Row(
        children: [
          CustomDrawer(widget.args.drawerWidth,3),
          Expanded(
            child: Scaffold(
              body:AdaptiveScrollbar(
                controller: _verticalScrollController,
                underColor: Colors.blueGrey.withOpacity(0.3),
                sliderDefaultColor: Colors.grey.withOpacity(0.7),
                sliderActiveColor: Colors.grey,
                position: ScrollbarPosition.right,
                child: AdaptiveScrollbar(
                  position: ScrollbarPosition.bottom,
                  underColor: Colors.blueGrey.withOpacity(0.3),
                  sliderDefaultColor: Colors.grey.withOpacity(0.7),
                  sliderActiveColor: Colors.grey,
                  controller: _horizontalScrollController,
                  child: SingleChildScrollView(
                    controller: _verticalScrollController,
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10,right: 45,left: 30,bottom: 140),
                          child: Card(elevation: 8,
                            child: SizedBox(width: MediaQuery.of(context).size.width >1140 ?MediaQuery.of(context).size.width-290:1140,
                              child: Column(
                                children: [
                                  Container(
                                     height:100,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 18,),
                                         Padding(
                                          padding: const EdgeInsets.only(left: 18.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:   [
                                              Row(
                                                children: [
                                                  const Text("Timesheet", style: TextStyle(color: Colors.indigo, fontSize: 22, fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 15,),
                                                  if(window.sessionStorage["userType"]=="Manager")
                                                  Container(
                                                    alignment: Alignment.topCenter,
                                                    color: Colors.lightBlueAccent[50],
                                                    width: 100,height: 24,
                                                    child: LayoutBuilder(
                                                      builder: (BuildContext context,
                                                          BoxConstraints constraints) {
                                                        return CustomPopupMenuButton(
                                                          elevation: 4,
                                                          decoration: customPopupDecoration(hintText: selectedUser,),
                                                          itemBuilder: (
                                                              BuildContext context) {
                                                            return ["User1","User2"].map((value) {
                                                              return CustomPopupMenuItem(
                                                                  value: value,
                                                                  text: value,
                                                                  child: Container()
                                                              );
                                                            }).toList();
                                                          },
                                                          onSelected: (value) {
                                                            selectedUser =value;
                                                            setState(() {

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
                                                ],
                                              ),
                                              SizedBox(height: 40,
                                                child: ToggleButtons(
                                                  borderWidth: 1.5,
                                                  borderColor: Colors.blue,
                                                  selectedBorderColor: Colors.blue,
                                                  fillColor: Colors.blue.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(5),
                                                  isSelected: isSelected,
                                                  onPressed: (int index) {
                                                    setState(() {
                                                      if(index==0) updateTotalHours("22:00");
                                                      if(index ==1) totalHours="00:00";
                                                      for (int i = 0; i < isSelected.length; i++) {
                                                        isSelected[i] = i == index;
                                                      }
                                                    });

                                                  },
                                                  children: const [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                      child: Text("Daily"),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                      child: Text("Weekly"),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                      child: Text("Monthly"),
                                                    ),
                                                  ],
                                                ),
                                              ),


                                             Text("Total Hrs: ${totalHours}", style: const TextStyle(color: Colors.indigo, fontSize: 22, fontWeight: FontWeight.bold),),


                                              Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: SizedBox(height: 50,width: 150,
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      TextFormField(
                                                        readOnly: true,
                                                        controller: dateController,
                                                        decoration: dateInputDecoration("Date",dateController),
                                                        onTap: ()=>_selectDate(context, dateController),
                                                        validator: (value)  {
                                                          if (value == null || value.trim().isEmpty) {
                                                            return 'Please select Date';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 30,),

                                        Divider(height: 0.5,color: Colors.grey[500],thickness: 0.5,),

                                      ],
                                    ),
                                  ),



                                  if(isSelected[0])
                                    DayExpandableTable(onTotalHoursUpdated: updateTotalHours, today:dateController.text),

                                  if(isSelected[1])
                                    WeeklyExpandableTable(onTotalHoursUpdated: updateTotalHours,weekDays:weekDays),
                                  if(isSelected[2])
                                    MonthlyTable(onTotalHoursUpdated: updateTotalHours,weekDays:monthDays),


                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }

  InputDecoration dateInputDecoration(String labelText, TextEditingController startDateController) {
    return InputDecoration(
      labelText: labelText,labelStyle:   const TextStyle(fontSize: 13),
      filled: true,
      fillColor: Colors.grey[100],
      suffixIcon: IconButton(
        icon: const Icon(Icons.calendar_today,color: Colors.blue),
        onPressed: () => _selectDate(context, startDateController),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }


  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate:DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        weekDays =getWeekDays(picked);
        controller.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }


  List<String> getWeekDays(DateTime date) {
    // Get the start of the week (Monday)
    DateTime startOfWeek = date.subtract(Duration(days: date.weekday));

    // Generate the list of past and current weekdays only
    List<String> weekDays = [];
    for (int i = 0; i < 7; i++) {
      DateTime currentDay = startOfWeek.add(Duration(days: i));
      if (currentDay.isAfter(DateTime.now())) break;
      weekDays.add("${currentDay.day}-${currentDay.month}-${currentDay.year}");
    }

    return weekDays;
  }

  List<String> getMonthDaysTillToday(DateTime date) {
    int today = date.day; // Get today's date

    List<String> monthDays = [];
    for (int i = 1; i <= today; i++) {
      monthDays.add("$i-${date.month}-${date.year}");
    }

    return monthDays;
  }



  // Callback function to update total hours
  void updateTotalHours(String newTotal) {
    setState(() {
      totalHours = newTotal;
    });
  }






  // Generate weeks for the selected month and pre-select the current week
  void generateWeeks() {
    weeks.clear();
    DateTime firstDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month, 1);
    DateTime lastDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);

    DateTime currentWeekStart = firstDayOfMonth;
    while (currentWeekStart.isBefore(lastDayOfMonth)) {
      DateTime currentWeekEnd = currentWeekStart.add(const Duration(days: 6)).isAfter(lastDayOfMonth)
          ? lastDayOfMonth
          : currentWeekStart.add(const Duration(days: 6));
      weeks.add([currentWeekStart, currentWeekEnd]);
      currentWeekStart = currentWeekEnd.add(const Duration(days: 1));
    }

    // Automatically select the current week
    selectedWeek = _getCurrentWeekIndex();
  }

  // Get the index of the current week in the selected month
  int? _getCurrentWeekIndex() {
    DateTime today = DateTime.now();
    for (int i = 0; i < weeks.length; i++) {
      if (today.isAfter(weeks[i][0].subtract(const Duration(days: 1))) &&
          today.isBefore(weeks[i][1].add(const Duration(days: 1)))) {
        return i;
      }
    }
    return null; // If today's date is outside the range (shouldn't happen)
  }

  // Show DatePicker for selecting a month
  Future<void> _selectMonth(BuildContext context) async {
    DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: selectedMonth,
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != selectedMonth) {
      setState(() {
        selectedMonth = picked;
        generateWeeks();
      });
    }
  }

  // Display days of the selected week
  List<String> getDaysOfWeek() {
    if (selectedWeek == null) return [];
    DateTime start = weeks[selectedWeek!][0];
    DateTime end = weeks[selectedWeek!][1];

    List<String> days = [];
    for (DateTime date = start;
    date.isBefore(end.add(const Duration(days: 1)));
    date = date.add(const Duration(days: 1))) {
      days.add(DateFormat('dd-MM-yyyy').format(date));
    }
    return days;
  }

  static customPopupDecoration({required String hintText}) {
    return InputDecoration(
      hoverColor: mHoverColor,
      disabledBorder:  InputBorder.none,
      suffixIcon: const Icon(Icons.arrow_drop_down_circle_sharp, color: mSaveButton, size: 14),
      border:  InputBorder.none,
      constraints: const BoxConstraints(maxHeight: 30),
      hintText: hintText=="" ?"Select":hintText ,
      hintStyle:  TextStyle(fontSize:hintText!='Select'?18: 18, color:hintText!='Select'? Colors.black:Colors.black54),
      counterText: '',
      contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 12),

    );
  }


}
