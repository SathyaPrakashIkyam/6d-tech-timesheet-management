import 'dart:html';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:timesheet_management/utils/classes/arguments_classes.dart';
import 'package:timesheet_management/utils/customAppBar.dart';
import 'package:timesheet_management/utils/customDrawer.dart';
import 'package:timesheet_management/wbs/create_wbs.dart';

import '../utils/api/get_api.dart';

class ListWBS extends StatefulWidget {
  final WBSArguments args;
  const ListWBS({super.key, required this.args});

  @override
  State<ListWBS> createState() => _ListWBSState();
}

class _ListWBSState extends State<ListWBS> {
   List displayListItems = [];

  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();

  getWBSList() async{
    String url = "https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/wbs/get_WBSList_by_user_id/${window.sessionStorage["userId"]}";

    var response = await getData(context: context,url: url);
    if (response != null) {
      displayListItems = response;
      setState(() {

      });
    } else {
      print('---- Failed to fetch WBS list ----');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWBSList();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const PreferredSize(    preferredSize: Size.fromHeight(60),
          child: CustomAppBar()),
      drawer: const AppBarDrawer(drawerWidth: 200,selectedDestination: 2),
      body: Row(
        children: [
          CustomDrawer(widget.args.drawerWidth,2),
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
                                              Text("WBS List", style: TextStyle(color: Colors.indigo, fontSize: 22, fontWeight: FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right: 50.0),
                                                // child: ElevatedButton.icon(
                                                //   onPressed: () {
                                                //     Navigator.push(
                                                //       context,
                                                //       PageRouteBuilder(
                                                //         transitionDuration: const Duration(milliseconds: 300), // Transition duration for push
                                                //         reverseTransitionDuration: const Duration(milliseconds: 300), // Transition duration for pop
                                                //         pageBuilder: (context, animation, secondaryAnimation) => const CreateWBS(),
                                                //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                //           return FadeTransition(
                                                //             opacity: animation,
                                                //             child: child,
                                                //           );
                                                //         },
                                                //       ),
                                                //     );
                                                //
                                                //   },
                                                //   icon: const Icon(Icons.add, color: Colors.white),
                                                //   label: const Text('Add WBS', style: TextStyle(color: Colors.white, fontSize: 16)),
                                                //   style: ElevatedButton.styleFrom(
                                                //     backgroundColor: Colors.blue,
                                                //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                //     shape: RoundedRectangleBorder(
                                                //       borderRadius: BorderRadius.circular(8),
                                                //     ),
                                                //     elevation: 4,
                                                //   ),
                                                // )



                                              )
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
                                              child:  Padding(
                                                padding: const EdgeInsets.only(left: 18.0),
                                                child: Row(
                                                  children: [
                                                    const Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4.0),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text("Project Name")
                                                          ),
                                                        )),
                                                    const Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4.0),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text("ID")
                                                          ),
                                                        )),
                                                    const Expanded(

                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4.0),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text("WBS Name")
                                                          ),
                                                        )),


                                                    const Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4),
                                                          child: SizedBox(
                                                              height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text('Priority')
                                                          ),
                                                        )
                                                    ),
                                                    const Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text("Members")
                                                          ),
                                                        )),
                                                    Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(),
                                                          child: Row(
                                                            children: [
                                                              Container(height: 20, width: 100,alignment: Alignment.topCenter,
                                                                  //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                                  child: const Text("Status")
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                    const Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text("Actual Date")
                                                          ),
                                                        )),
                                                    const Expanded(
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

                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 18.0,top: 4,bottom: 3),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 4.0),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child:
                                                              Text("${displayListItems[index]['project_name']}$index")
                                                            //Text(displayListItems[index]['billAddressName']??"")
                                                          ),
                                                        )),
                                                    Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 4.0),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text(displayListItems[index]['wbs_id']??"")
                                                            //Text(displayListItems[index]['estVehicleId']??"")
                                                          ),
                                                        )),
                                                    Expanded(

                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 4.0),
                                                          child: SizedBox(
                                                              height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child:
                                                              Text("${displayListItems[index]['wbs_name']}")
                                                            //Text(displayListItems[index]['billAddressName']??"")
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
                                                              String member = entry.value["member"];
                                                              return Positioned(
                                                                left: i * 16.0,
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
