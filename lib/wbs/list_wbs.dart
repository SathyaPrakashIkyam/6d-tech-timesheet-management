import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:timesheet_management/utils/classes/arguments_classes.dart';
import 'package:timesheet_management/utils/customAppBar.dart';
import 'package:timesheet_management/utils/customDrawer.dart';
import 'package:timesheet_management/wbs/create_wbs.dart';

class ListWBS extends StatefulWidget {
  final WBSArguments args;
  const ListWBS({super.key, required this.args});

  @override
  State<ListWBS> createState() => _ListWBSState();
}

class _ListWBSState extends State<ListWBS> {
  final List displayListItems = [
    {
      'id': '2246',
      'name': 'Project 01',
      'projectName': 'WBS Task 01',
      'priority': 'High',
      'priorityColor': Colors.green,
      'status': 'Ongoing',
      'statusColor': Colors.orange,
      'startDate': '16/12/2024',
      'dueDate': '16/12/2024',
      'members': ['Rahul',]
    },
    {
      'id': '2334',
      'name': 'Project 02',
      'projectName': 'WBS Task 02',
      'priority': 'Low',
      'priorityColor': Colors.red,
      'status': 'Completed',
      'statusColor': Colors.green,
      'startDate': '18/12/2024',
      'dueDate': '18/12/2024',
      'members': ['Ganesh' ]
    },
    {
      'id': '2414',
      'name': 'Project 03',
      'projectName': 'WBS Task 03',
      'priority': 'Medium',
      'priorityColor': Colors.orange,
      'status': 'Yet to start',
      'statusColor': Colors.red,
      'startDate': '20/12/2024',
      'dueDate': '20/12/2024',
      'members': [ 'Akhil', 'Kiran',"Tejes"]
    },

  ];

  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();

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
                                                          padding: EdgeInsets.only(top: 4.0),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text("Project Name")
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
                                                              child: Text("Start Date")
                                                          ),
                                                        )),
                                                    const Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text("Due Date")
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
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 4.0),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text(displayListItems[index]['id']??"")
                                                            //Text(displayListItems[index]['estVehicleId']??"")
                                                          ),
                                                        )),
                                                    Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 4.0),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child:
                                                              Text("${displayListItems[index]['projectName']}$index")
                                                            //Text(displayListItems[index]['billAddressName']??"")
                                                          ),
                                                        )),
                                                    Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 4.0),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child:
                                                              Text("${displayListItems[index]['name']}$index")
                                                            //Text(displayListItems[index]['billAddressName']??"")
                                                          ),
                                                        )),
                                                    Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 4.0),
                                                          child: Container(alignment: Alignment.centerLeft,
                                                              child: Chip(
                                                                label: Text(displayListItems[index]['priority']),
                                                                avatar: Icon(Icons.flag, size: 16, color: displayListItems[index]['priorityColor']),
                                                                backgroundColor: displayListItems[index]['priorityColor'].withOpacity(0.1),
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
                                                              Container(alignment: Alignment.centerLeft,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: displayListItems[index]['statusColor']),
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
                                                              child: Text(displayListItems[index]['startDate']??"")
                                                            //Text(displayListItems[index]['estVehicleId']??"")
                                                          ),
                                                        )),
                                                    Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 4.0),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text(displayListItems[index]['dueDate']??"")
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
