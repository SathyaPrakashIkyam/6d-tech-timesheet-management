import 'package:flutter/material.dart';
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

  final List displayListItems = [
    {
      'id': '2444',
      'name': 'Project 01',
      'priority': 'High',
      'priorityColor': Colors.green,
      'status': 'Ongoing',
      'statusColor': Colors.orange,
      'startDate': '16/12/2024',
      'dueDate': '16/12/2024',
      'members': ['Assdf', 'A', 'A',"Sathya"]
    },
    {
      'id': '2334',
      'name': 'Project 02',
      'priority': 'Low',
      'priorityColor': Colors.red,
      'status': 'Completed',
      'statusColor': Colors.green,
      'startDate': '18/12/2024',
      'dueDate': '18/12/2024',
      'members': ['G', 'S', ]
    },
    {
      'id': '2414',
      'name': 'Project 03',
      'priority': 'Medium',
      'priorityColor': Colors.orange,
      'status': 'Yet to start',
      'statusColor': Colors.red,
      'startDate': '20/12/2024',
      'dueDate': '20/12/2024',
      'members': [ 'A', 'K',"Te"]
    },

  ];


  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();

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
                                                            child: Text("Start Date")
                                                        ),
                                                      )),
                                                  Expanded(
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
                                                            child: Text(displayListItems[index]['id']??"")
                                                          //Text(displayListItems[index]['estVehicleId']??"")
                                                        ),
                                                      )),
                                                  Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 4.0),
                                                        child: SizedBox(height: 25,
                                                         child: Text("${displayListItems[index]['name']}$index")
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
                                                              left: i * 16.0, // Adjust spacing for overlap
                                                              child: CircleAvatar(
                                                                radius: 12,
                                                                backgroundColor: Colors.primaries[i % Colors.primaries.length], // Different colors
                                                                child: Text(
                                                                  member[0],
                                                                  style: const TextStyle(color: Colors.white, fontSize: 12),
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
