import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:timesheet_management/utils/classes/arguments_classes.dart';

import '../utils/api/get_api.dart';
import '../utils/customAppBar.dart';
import '../utils/customDrawer.dart';

class UserList extends StatefulWidget {
  final UserListArguments args;
  const UserList({super.key, required this.args});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();

  List displayUserList = [];

  getUserList() async{
    String url = "https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/usermaster/get-all-user";

    var response = await getData(context: context,url: url);
    if (response != null) {
      displayUserList = response;
      setState(() {

      });
    } else {
      print('---- Failed to fetch User list ----');
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()
      ),
      drawer: AppBarDrawer(drawerWidth: widget.args.drawerWidth,selectedDestination: 4),
      body: Row(
        children: [
          CustomDrawer(widget.args.drawerWidth,4),
          Expanded(
              child: Scaffold(
                body: AdaptiveScrollbar(
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
                            padding: const EdgeInsets.only(top: 10,right: 30,left: 30),
                          child: Card(
                            elevation: 8,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width >1140 ?MediaQuery.of(context).size.width-290:1140,
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
                                         Padding(
                                          padding: const EdgeInsets.only(left: 18.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:   [
                                              const Text("User List", style: TextStyle(color: Colors.indigo, fontSize: 22, fontWeight: FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 15, bottom: 10, right: 20),
                                                child: MaterialButton(
                                                  color: Colors.blue,
                                                    onPressed: () {
                                                      Navigator.pushNamed(context, "/createUsers",arguments: CreateUsersArguments(drawerWidth: widget.args.drawerWidth,selectedDestination: widget.args.selectedDestination));
                                                    },
                                                  child: const Text("Create Users", style: TextStyle(color: Colors.white)),
                                                ),
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
                                                              child: Text("Name")
                                                          ),
                                                        )),
                                                    Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4.0),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text("Email")
                                                          ),
                                                        )),

                                                    Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4),
                                                          child: SizedBox(
                                                              height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text('Department')
                                                          ),
                                                        )
                                                    ),
                                                    Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text("Role")
                                                          ),
                                                        )),
                                                    Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text("Designation")
                                                          ),
                                                        )),
                                                    Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4),
                                                          child: SizedBox(height: 25,
                                                              //   decoration: state.text.isNotEmpty ?BoxDecoration():BoxDecoration(boxShadow: [BoxShadow(color:Color(0xFFEEEEEE),blurRadius: 2)]),
                                                              child: Text("Type")
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
                                    itemCount: displayUserList.length + 1,
                                      itemBuilder: (context, index) {
                                        if(index < displayUserList.length){
                                          return Column(
                                            children: [
                                              if(displayUserList[index]['roles'] != "Admin")
                                              MaterialButton(
                                                  onPressed: () {

                                                  },
                                                child: Padding(
                                                    padding: const EdgeInsets.only(left: 18.0,top: 4,bottom: 3),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 4.0),
                                                            child: SizedBox(
                                                                height: 25,
                                                                child: Text(displayUserList[index]['user_name']??"")
                                                            ),
                                                          )
                                                      ),
                                                      Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 4.0),
                                                            child: SizedBox(
                                                                height: 25,
                                                                child: Text(displayUserList[index]['email']??"")
                                                            ),
                                                          )
                                                      ),
                                                      Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 4.0),
                                                            child: SizedBox(
                                                                height: 25,
                                                                child: Text(displayUserList[index]['department']??"")
                                                            ),
                                                          )
                                                      ),
                                                      Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 4.0),
                                                            child: SizedBox(
                                                                height: 25,
                                                                child: Text(displayUserList[index]['roles']??"")
                                                            ),
                                                          )
                                                      ),
                                                      Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 4.0),
                                                            child: SizedBox(
                                                                height: 25,
                                                                child: Text(displayUserList[index]['designation']??"")
                                                            ),
                                                          )
                                                      ),
                                                      Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 4.0),
                                                            child: SizedBox(
                                                                height: 25,
                                                                child: Text(displayUserList[index]['user_set']??"")
                                                            ),
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        } else {
                                          return Column(
                                            children: [
                                              Divider(height: 0.5, color: Colors.grey[300], thickness: 0.5),
                                              const SizedBox(height: 10,),
                                            ],
                                          );
                                        }
                                      },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
