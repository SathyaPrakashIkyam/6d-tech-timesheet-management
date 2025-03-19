import 'dart:html';

import 'package:flutter/material.dart';
import 'package:timesheet_management/utils/api/get_api.dart';
import 'package:timesheet_management/utils/classes/arguments_classes.dart';
import 'package:timesheet_management/utils/customAppBar.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';

import '../utils/customDrawer.dart';

class ListProjects extends StatefulWidget {
  final ListProjectsArguments args;
  const ListProjects({super.key, required this.args});

  @override
  State<ListProjects> createState() => _ListProjectsState();
}

class _ListProjectsState extends State<ListProjects> {

  List displayListItems = [];


  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();

  getProjectList() async{
    String url = "https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/projectcreation/get_all_Projects_By_user_id/${window.sessionStorage["userId"]}";
    var response = await getData(context: context,url: url);
    if (response != null) {
      displayListItems = response;
      setState(() {

      });
    } else {
      print('---- Failed to fetch project list ----');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProjectList();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      drawer: AppBarDrawer(drawerWidth: widget.args.drawerWidth,selectedDestination: 1),
      body: Row(
        children: [
          CustomDrawer(widget.args.drawerWidth,1),
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
                            top: 10,right: 30,left: 30),
                        child: Card(elevation: 8,
                          child: SizedBox(width: MediaQuery.of(context).size.width >1140 ?MediaQuery.of(context).size.width-290:1140,
                            child: Column(
                              children: [
                                Container(
                                  // height:100,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 18,),
                                       const Padding(
                                        padding: EdgeInsets.only(left: 18.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:   [
                                            Text("Project List", style: TextStyle(color: Colors.indigo, fontSize: 22, fontWeight: FontWeight.bold),
                                            ),

                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 30,),

                                      Divider(height: 0.5,color: Colors.grey[500],thickness: 0.5,),
                                      Container(color: Colors.grey[100],
                                        //height: 32,
                                        child:  IgnorePointer(
                                          ignoring: true,
                                          child: MaterialButton(height: 60,
                                            onPressed: (){},
                                            hoverColor: Colors.transparent,
                                            hoverElevation: 0,
                                            child: const Padding(
                                              padding: EdgeInsets.only(left: 18.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(top: 4.0),
                                                        child: SizedBox(height: 25,
                                                            //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                            child: Text("ID")
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(top: 4.0),
                                                        child: SizedBox(height: 25,
                                                            //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                            child: Text("Project Name")
                                                        ),
                                                      )),

                                                  Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(top: 4),
                                                        child: SizedBox(
                                                            height: 25,
                                                            //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                            child: Text('Priority')
                                                        ),
                                                      )
                                                  ),
                                                  Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(top: 4),
                                                        child: SizedBox(height: 25,
                                                            //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                            child: Text("Members")
                                                        ),
                                                      )),
                                                  Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(top: 4),
                                                        child: SizedBox(height: 25,
                                                            //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                            child: Text("Status")
                                                        ),
                                                      )),
                                                  Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(top: 4),
                                                        child: SizedBox(height: 25,
                                                            //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                            child: Text("Actual Date")
                                                        ),
                                                      )),
                                                  Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(top: 4),
                                                        child: SizedBox(height: 25,
                                                            //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                            child: Text("End Date")
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(height: 0.5,color: Colors.grey[500],thickness: 0.5,),
                                      const SizedBox(height: 4,)
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: displayListItems.length + 1,
                                  itemBuilder: ( context, index) {
                                    if(index < displayListItems.length){
                                      //print(displayListItems[index]['orderDate'].runtimeType);
                                      Color priHigh = Colors.green;
                                      Color priMedium = Colors.orange;
                                      Color priLow = Colors.red;
                                      String priority = displayListItems[index]['priority'];
                                      String status = displayListItems[index]['status'];
                                      return Column(
                                        children: [
                                          MaterialButton(height: 50,
                                            hoverColor: Colors.blue[50],
                                            onPressed: (){
                                            Navigator.pushNamed(context, "/projectView", arguments: ViewProjectsArguments(
                                              drawerWidth: 200,
                                              selectedDestination: 1,
                                              projectData: displayListItems[index],
                                            ));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 18.0,top: 4,bottom: 3),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 4.0),
                                                        child: SizedBox(height: 25,
                                                            //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                            child: Text(displayListItems[index]['project_id']??"")
                                                          //Text(displayListItems[index]['estVehicleId']??"")
                                                        ),
                                                      )),
                                                  Expanded(
                                                    flex: 2,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 4.0),
                                                        child: SizedBox(
                                                            height: 25,
                                                         child: Text("${displayListItems[index]['project_name']}$index")
                                                        ),
                                                      )),
                                                  Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 4.0),
                                                        child: Container(alignment: Alignment.centerLeft,
                                                            child: Chip(
                                                              label: Text(displayListItems[index]['priority']),
                                                              avatar: Icon(Icons.flag, size: 16, color: priority == "High" ? priHigh : priority == "Medium" ? priMedium : priLow),
                                                              backgroundColor: (priority == "High" ? priHigh : priority == "Medium" ? priMedium : priLow).withOpacity(0.1),
                                              )
                                                        ),
                                                      )),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 4),
                                                      child: SizedBox(
                                                        height: 25, // Set fixed height
                                                        child: Stack(
                                                          children: displayListItems[index]['members'].asMap().entries.map<Widget>((entry) {
                                                            int i = entry.key;
                                                            String member = entry.value;
                                                            return Positioned(
                                                              left: i * 16.0, // Adjust spacing for overlap
                                                              child: Tooltip(
                                                                message: member,
                                                                child: CircleAvatar(
                                                                  radius: 12,
                                                                  backgroundColor: Colors.primaries[i % Colors.primaries.length], // Different colors
                                                                  child: Text(
                                                                    member[0],
                                                                    style: const TextStyle(color: Colors.white, fontSize: 12),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Padding(
                                                        padding:  const EdgeInsets.only(top: 4),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              alignment: Alignment.centerLeft,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(20),
                                                                  color: status == "Completed" ? priHigh : status == "ongoing" ? priMedium : priLow
                                                              ),
                                                              height: 30,width: 120,
                                                              child: Center(child: Text( displayListItems[index]['status'],style: const TextStyle(color: Colors.white),)),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                  ),
                                                  Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 4.0),
                                                        child: SizedBox(height: 25,
                                                            //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                            child: Text(displayListItems[index]['start_date']??"")
                                                          //Text(displayListItems[index]['estVehicleId']??"")
                                                        ),
                                                      )),
                                                  Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 4.0),
                                                        child: SizedBox(height: 25,
                                                            //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                            child: Text(displayListItems[index]['end_date']??"")
                                                          //Text(displayListItems[index]['estVehicleId']??"")
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(height: 0.5, color: Colors.grey[300], thickness: 0.5),
                                        ],
                                      );
                                    }
                                    else{
                                      return Column(
                                        children: [
                                          Divider(height: 0.5, color: Colors.grey[300], thickness: 0.5),
                                          const SizedBox(height: 10,),
                                        ],
                                      );
                                    }
                                  },
                                ),
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
}
