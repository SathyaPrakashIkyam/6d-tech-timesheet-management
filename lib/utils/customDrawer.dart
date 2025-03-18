
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_management/utils/static_data/motows_colors.dart';
import '../bloc/bloc.dart';
import 'classes/arguments_classes.dart';





class CustomDrawer extends StatefulWidget {
  final double drawerWidth;
  final double selectedDestination;
  const CustomDrawer(this.drawerWidth, this.selectedDestination, {Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late double drawerWidth;

  late double _selectedDestination;
  String userRole = "";
  List<bool> sideBarList = [false, false, false, false];
  getInitialData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? sidebarString = prefs.getString('sideBar');
    // if (sidebarString != null) {
    //   sideBarList = List<bool>.from(json.decode(sidebarString));
    // }
    setState(() {
      if(prefs.getString('role')=="Manager") {
        userRole = prefs.getString('role')!;
      }else if(prefs.getString('role') == "User"){
        userRole = prefs.getString('role')!;
      }else if(prefs.getString('role') == "Admin"){
        userRole = prefs.getString('role')!;
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitialData();
    drawerWidth = widget.drawerWidth;
    _selectedDestination = widget.selectedDestination;
    // Home
    if(_selectedDestination==0){
      homeHovered=true;
    }



  }

  @override
  dispose(){
    super.dispose();
  }
  bool homeHovered=false;



  // bool serviceHover = false;
  // bool serviceExpanded=false;
  bool vehicleOrdersColorB=false;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.getStream,
        initialData: bloc.loginData,
      builder: (context, AsyncSnapshot snapshot) {
        return LayoutBuilder(
          builder:(context, constraints) {
            if(MediaQuery.of(context).size.width>800) {
              return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: drawerWidth,
            child: Scaffold(
              //  backgroundColor: Colors.white,
              body: Drawer(

                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff0D47A1), Colors.lightBlueAccent,], // Define gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ListView(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      // SizedBox(
                      //   height: 50,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(top: 4,bottom: 4),
                      //     child: Image.asset("assets/logo/sap.png",fit: BoxFit.fitHeight),
                      //   ),
                      // ),
                      const SizedBox(height: 10,),

                        /// Dashboard
                        if (drawerWidth==60) InkWell(
                        hoverColor: mHoverColor,
                        onTap: (){
                          setState(() {
                            drawerWidth = 200;
                          });
                        },
                        child: SizedBox(height: 40,
                          child: Icon(Icons.apps_rounded,
                            color: _selectedDestination == 0 ? Colors.blue: Colors.black54,),
                        ),
                      ) else MouseRegion(
                          onHover: (event){
                            setState((){
                              homeHovered=true;
                            });
                          },
                          onExit: (event){
                            setState(() {
                              homeHovered=false;
                            });

                          },
                          child: Padding(
                            padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 8),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==0 ? Colors.white:Colors.transparent,),

                              child: ListTileTheme(
                                contentPadding: const EdgeInsets.only(left: 0),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/dashboard");
                                    // Navigator.push(
                                    //   context,
                                    //   PageRouteBuilder(
                                    //     pageBuilder: (context, animation, secondaryAnimation) => const Dashboard(),
                                    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    //       var fadeTween = Tween<double>(begin: 0.0, end: 1.0);
                                    //
                                    //       return FadeTransition(
                                    //         opacity: animation.drive(fadeTween),
                                    //         child: child,
                                    //       );
                                    //     },
                                    //   ),
                                    // );

                                  },
                                  leading:  SizedBox(width: 40,child: Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Icon(Icons.apps_rounded,color: _selectedDestination==0? Colors.black:Colors.white),
                                  ),),
                                  title:    Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 10),
                                    child: Text(
                                      drawerWidth == 60 ? '' : 'Dashboard',
                                      style:  TextStyle(fontSize: 17,color: _selectedDestination==0? Colors.black:Colors.white),

                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      /// Project
                      drawerWidth==60?
                      InkWell(
                        hoverColor: mHoverColor,
                        onTap: (){
                          setState(() {
                            drawerWidth = 200;
                          });
                        },
                        child: SizedBox(height: 40,
                          child: Icon(Icons.file_copy,
                            color: _selectedDestination == 1 ? Colors.black: Colors.white,),
                        ),
                      ):
                      MouseRegion(
                        onHover: (event){
                          setState((){
                            homeHovered=true;
                          });
                        },
                        onExit: (event){
                          setState(() {
                            homeHovered=false;
                          });

                        },
                        child: Padding(
                          padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 4),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==1 ? Colors.white:Colors.transparent,),

                            child: ListTileTheme(
                              contentPadding: const EdgeInsets.only(left: 0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, "/projects",arguments: ListProjectsArguments(drawerWidth: drawerWidth,selectedDestination: 1));
                                },
                                leading:  SizedBox(width: 40,child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(Icons.file_copy_sharp,color: _selectedDestination==1? Colors.black:Colors.white),
                                ),),
                                title:    Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 10),
                                  child: Text(
                                    drawerWidth == 60 ? '' : 'Projects',
                                    style:  TextStyle(fontSize: 17,color: _selectedDestination==1? Colors.black:Colors.white),

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),


                      /// WBS
                      drawerWidth==60?
                      InkWell(
                        hoverColor: mHoverColor,
                        onTap: (){
                          setState(() {
                            drawerWidth = 200;
                          });
                        },
                        child: SizedBox(height: 40,
                          child: Icon(Icons.backup_table_rounded,
                            color: _selectedDestination == 2 ? Colors.black: Colors.white,),
                        ),
                      ):
                      MouseRegion(
                        onHover: (event){
                          setState((){
                            homeHovered=true;
                          });
                        },
                        onExit: (event){
                          setState(() {
                            homeHovered=false;
                          });

                        },
                        child: Padding(
                          padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 4),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==2 ? Colors.white:Colors.transparent,),

                            child: ListTileTheme(
                              contentPadding: const EdgeInsets.only(left: 0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, "/wbs");
                                },
                                leading:  SizedBox(width: 40,child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(Icons.backup_table_rounded,color: _selectedDestination==2? Colors.black:Colors.white),
                                ),),
                                title:    Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 10),
                                  child: Text(
                                    drawerWidth == 60 ? '' : 'WBS',
                                    style:  TextStyle(fontSize: 17,color: _selectedDestination==2? Colors.black:Colors.white),

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),


                      /// TimeSheet
                      drawerWidth==60?
                      InkWell(
                        hoverColor: mHoverColor,
                        onTap: (){
                          setState(() {
                            drawerWidth = 200;
                          });
                        },
                        child: SizedBox(height: 40,
                          child: Icon(Icons.timelapse_outlined,
                            color: _selectedDestination == 3 ? Colors.black: Colors.white,),
                        ),
                      ):
                      MouseRegion(
                        onHover: (event){
                          setState((){
                            homeHovered=true;
                          });
                        },
                        onExit: (event){
                          setState(() {
                            homeHovered=false;
                          });

                        },
                        child: Padding(
                           padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 4),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==3 ? Colors.white:Colors.transparent,),

                            child: ListTileTheme(
                              contentPadding: const EdgeInsets.only(left: 0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, "/timesheet",arguments: ListTimeSheetArguments(drawerWidth: drawerWidth,selectedDestination: 3));
                                  // Navigator.pushReplacementNamed(context, "/wbs");
                                },
                                leading:  SizedBox(width: 40,child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(Icons.timelapse_outlined,color: _selectedDestination==3? Colors.black:Colors.white),
                                ),),
                                title:    Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 10),
                                  child: Text(
                                    drawerWidth == 60 ? '' : 'Time Sheet',
                                    style:  TextStyle(fontSize: 17,color: _selectedDestination==3? Colors.black:Colors.white),

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// User Management
                      drawerWidth==60?
                      InkWell(
                        hoverColor: mHoverColor,
                        onTap: (){
                          setState(() {
                            drawerWidth = 200;
                          });
                        },
                        child: SizedBox(height: 40,
                          child: Icon(Icons.supervised_user_circle_sharp,
                            color: _selectedDestination == 4 ? Colors.black: Colors.white,),
                        ),
                      ):
                      MouseRegion(
                        onHover: (event){
                          setState((){
                            homeHovered=true;
                          });
                        },
                        onExit: (event){
                          setState(() {
                            homeHovered=false;
                          });

                        },
                        child: Padding(
                          padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 4),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==4 ? Colors.white:Colors.transparent,),

                            child: ListTileTheme(
                              contentPadding: const EdgeInsets.only(left: 0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, "/createUsers",arguments: CreateUsersArguments(drawerWidth: drawerWidth,selectedDestination: 4));
                                },
                                leading:  SizedBox(width: 40,child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(Icons.supervised_user_circle_sharp,color: _selectedDestination==4? Colors.black:Colors.white),
                                ),),
                                title:    Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 10),
                                  child: Text(
                                    drawerWidth == 60 ? '' : 'User Management',
                                    style:  TextStyle(fontSize: 17,color: _selectedDestination==4? Colors.black:Colors.white),

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),


                      /// Attendance
                      // drawerWidth==60?
                      // InkWell(
                      //   hoverColor: mHoverColor,
                      //   onTap: (){
                      //     setState(() {
                      //       drawerWidth = 200;
                      //     });
                      //   },
                      //   child: SizedBox(height: 40,
                      //     child: Icon(Icons.auto_graph_rounded,
                      //       color: _selectedDestination == 4 ? Colors.black: Colors.white,),
                      //   ),
                      // ):
                      // MouseRegion(
                      //   onHover: (event){
                      //     setState((){
                      //       homeHovered=true;
                      //     });
                      //   },
                      //   onExit: (event){
                      //     setState(() {
                      //       homeHovered=false;
                      //     });
                      //
                      //   },
                      //   child: Padding(
                      //     padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 4),
                      //     child: Container(
                      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==4 ? Colors.white:Colors.transparent,),
                      //
                      //       child: ListTileTheme(
                      //         contentPadding: const EdgeInsets.only(left: 0),
                      //         child: ListTile(
                      //           onTap: () {
                      //             // Navigator.pushReplacementNamed(context, "/wbs");
                      //           },
                      //           leading:  SizedBox(width: 40,child: Padding(
                      //             padding: const EdgeInsets.only(left: 4.0),
                      //             child: Icon(Icons.auto_graph_rounded,color: _selectedDestination==4? Colors.black:Colors.white),
                      //           ),),
                      //           title:    Padding(
                      //             padding: const EdgeInsets.only(left: 8.0,right: 10),
                      //             child: Text(
                      //               drawerWidth == 60 ? '' : 'Attendance',
                      //               style:  TextStyle(fontSize: 17,color: _selectedDestination==4? Colors.black:Colors.white),
                      //
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),


                      /// Report
                      // drawerWidth==60?
                      // InkWell(
                      //   hoverColor: mHoverColor,
                      //   onTap: (){
                      //     setState(() {
                      //       drawerWidth = 200;
                      //     });
                      //   },
                      //   child: SizedBox(height: 40,
                      //     child: Icon(Icons.add_chart_outlined,
                      //       color: _selectedDestination == 5 ? Colors.black: Colors.white,),
                      //   ),
                      // ):
                      // MouseRegion(
                      //   onHover: (event){
                      //     setState((){
                      //       homeHovered=true;
                      //     });
                      //   },
                      //   onExit: (event){
                      //     setState(() {
                      //       homeHovered=false;
                      //     });
                      //
                      //   },
                      //   child: Padding(
                      //     padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 4),
                      //     child: Container(
                      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==5 ? Colors.white:Colors.transparent,),
                      //
                      //       child: ListTileTheme(
                      //         contentPadding: const EdgeInsets.only(left: 0),
                      //         child: ListTile(
                      //           onTap: () {
                      //             // Navigator.pushReplacementNamed(context, "/wbs");
                      //           },
                      //           leading:  SizedBox(width: 40,child: Padding(
                      //             padding: const EdgeInsets.only(left: 4.0),
                      //             child: Icon(Icons.add_chart_outlined,color: _selectedDestination==5? Colors.black:Colors.white),
                      //           ),),
                      //           title:    Padding(
                      //             padding: const EdgeInsets.only(left: 8.0,right: 10),
                      //             child: Text(
                      //               drawerWidth == 60 ? '' : 'Reports',
                      //               style:  TextStyle(fontSize: 17,color: _selectedDestination==5? Colors.black:Colors.white),
                      //
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),




                    ],
                  ),
                ),
              ),
              bottomNavigationBar: SizedBox(
                height: 30,
                width: 50,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        if (drawerWidth == 60) {
                          drawerWidth = 200;
                        } else {
                          drawerWidth = 60;
                        }
                      });
                    },
                    child:
                    Row(

                      children: [
                        drawerWidth==200?  const Expanded(
                          child: Row(
                            children: [
                              Spacer(),
                              // Flexible(child: Center(child: Image.asset("assets/logo/Ikyam_color_logo.png"))),
                              Center(child: Text("minimize",style: TextStyle(color: Colors.black,fontSize: 11),)),
                              Spacer(),
                              Flexible(child: Icon(Icons.arrow_back_ios_new_rounded,size: 18,))
                            ],
                          ),
                        ):const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Center(child: Icon(Icons.arrow_forward_ios_rounded,size: 18,)),
                        ),
                       // Text(drawerWidth == 60 ? ">" : "<"),
                      ],
                    )),
              ),

            ),
          );
            }
            else{
              return Container();
            }
          },
        );
      }
    );
  }

  void selectDestination(double index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}



class AppBarDrawer extends StatefulWidget {
  final double drawerWidth;
  final double selectedDestination;
  const AppBarDrawer({super.key, required this.drawerWidth, required this.selectedDestination});

  @override
  State<AppBarDrawer> createState() => _AppBarDrawerState();
}

class _AppBarDrawerState extends State<AppBarDrawer> {
  late double drawerWidth;

  late double _selectedDestination;
  String userRole = "";
  List<bool> sideBarList = [false, false, false, false];
  getInitialData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? sidebarString = prefs.getString('sideBar');
    // if (sidebarString != null) {
    //   sideBarList = List<bool>.from(json.decode(sidebarString));
    // }
    setState(() {
      if(prefs.getString('role')=="Manager") {
        userRole = prefs.getString('role')!;
      }else if(prefs.getString('role') == "User"){
        userRole = prefs.getString('role')!;
      }else if(prefs.getString('role') == "Admin"){
        userRole = prefs.getString('role')!;
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitialData();
    drawerWidth = widget.drawerWidth;
    _selectedDestination = widget.selectedDestination;
    // Home
    if(_selectedDestination==0){
      homeHovered=true;
    }



  }

  @override
  dispose(){
    super.dispose();
  }
  bool homeHovered=false;



  // bool serviceHover = false;
  // bool serviceExpanded=false;
  bool vehicleOrdersColorB=false;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.getStream,
        initialData: bloc.loginData,
        builder: (context, AsyncSnapshot snapshot) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: drawerWidth,
            child: Scaffold(
              //  backgroundColor: Colors.white,
              body: Drawer(

                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff0D47A1), Colors.lightBlueAccent,], // Define gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ListView(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      // SizedBox(
                      //   height: 50,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(top: 4,bottom: 4),
                      //     child: Image.asset("assets/logo/sap.png",fit: BoxFit.fitHeight),
                      //   ),
                      // ),
                      const SizedBox(height: 10,),

                      /// Dashboard
                      if (drawerWidth==60) InkWell(
                        hoverColor: mHoverColor,
                        onTap: (){
                          setState(() {
                            drawerWidth = 200;
                          });
                        },
                        child: SizedBox(height: 40,
                          child: Icon(Icons.apps_rounded,
                            color: _selectedDestination == 0 ? Colors.blue: Colors.black54,),
                        ),
                      ) else MouseRegion(
                        onHover: (event){
                          setState((){
                            homeHovered=true;
                          });
                        },
                        onExit: (event){
                          setState(() {
                            homeHovered=false;
                          });

                        },
                        child: Padding(
                          padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 8),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==0 ? Colors.white:Colors.transparent,),

                            child: ListTileTheme(
                              contentPadding: const EdgeInsets.only(left: 0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, "/dashboard");
                                  // Navigator.push(
                                  //   context,
                                  //   PageRouteBuilder(
                                  //     pageBuilder: (context, animation, secondaryAnimation) => const Dashboard(),
                                  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  //       var fadeTween = Tween<double>(begin: 0.0, end: 1.0);
                                  //
                                  //       return FadeTransition(
                                  //         opacity: animation.drive(fadeTween),
                                  //         child: child,
                                  //       );
                                  //     },
                                  //   ),
                                  // );

                                },
                                leading:  SizedBox(width: 40,child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(Icons.apps_rounded,color: _selectedDestination==0? Colors.black:Colors.white),
                                ),),
                                title:    Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 10),
                                  child: Text(
                                    drawerWidth == 60 ? '' : 'Dashboard',
                                    style:  TextStyle(fontSize: 17,color: _selectedDestination==0? Colors.black:Colors.white),

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// Project
                      drawerWidth==60?
                      InkWell(
                        hoverColor: mHoverColor,
                        onTap: (){
                          setState(() {
                            drawerWidth = 200;
                          });
                        },
                        child: SizedBox(height: 40,
                          child: Icon(Icons.file_copy,
                            color: _selectedDestination == 1 ? Colors.black: Colors.white,),
                        ),
                      ):
                      MouseRegion(
                        onHover: (event){
                          setState((){
                            homeHovered=true;
                          });
                        },
                        onExit: (event){
                          setState(() {
                            homeHovered=false;
                          });

                        },
                        child: Padding(
                          padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 4),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==1 ? Colors.white:Colors.transparent,),

                            child: ListTileTheme(
                              contentPadding: const EdgeInsets.only(left: 0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, "/projects",arguments: ListProjectsArguments(drawerWidth: drawerWidth,selectedDestination: 1));
                                },
                                leading:  SizedBox(width: 40,child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(Icons.file_copy_sharp,color: _selectedDestination==1? Colors.black:Colors.white),
                                ),),
                                title:    Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 10),
                                  child: Text(
                                    drawerWidth == 60 ? '' : 'Projects',
                                    style:  TextStyle(fontSize: 17,color: _selectedDestination==1? Colors.black:Colors.white),

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),


                      /// WBS
                      drawerWidth==60?
                      InkWell(
                        hoverColor: mHoverColor,
                        onTap: (){
                          setState(() {
                            drawerWidth = 200;
                          });
                        },
                        child: SizedBox(height: 40,
                          child: Icon(Icons.backup_table_rounded,
                            color: _selectedDestination == 2 ? Colors.black: Colors.white,),
                        ),
                      ):
                      MouseRegion(
                        onHover: (event){
                          setState((){
                            homeHovered=true;
                          });
                        },
                        onExit: (event){
                          setState(() {
                            homeHovered=false;
                          });

                        },
                        child: Padding(
                          padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 4),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==2 ? Colors.white:Colors.transparent,),

                            child: ListTileTheme(
                              contentPadding: const EdgeInsets.only(left: 0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, "/wbs");
                                },
                                leading:  SizedBox(width: 40,child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(Icons.backup_table_rounded,color: _selectedDestination==2? Colors.black:Colors.white),
                                ),),
                                title:    Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 10),
                                  child: Text(
                                    drawerWidth == 60 ? '' : 'WBS',
                                    style:  TextStyle(fontSize: 17,color: _selectedDestination==2? Colors.black:Colors.white),

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),


                      /// TimeSheet
                      drawerWidth==60?
                      InkWell(
                        hoverColor: mHoverColor,
                        onTap: (){
                          setState(() {
                            drawerWidth = 200;
                          });
                        },
                        child: SizedBox(height: 40,
                          child: Icon(Icons.timelapse_outlined,
                            color: _selectedDestination == 3 ? Colors.black: Colors.white,),
                        ),
                      ):
                      MouseRegion(
                        onHover: (event){
                          setState((){
                            homeHovered=true;
                          });
                        },
                        onExit: (event){
                          setState(() {
                            homeHovered=false;
                          });

                        },
                        child: Padding(
                          padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 4),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==3 ? Colors.white:Colors.transparent,),

                            child: ListTileTheme(
                              contentPadding: const EdgeInsets.only(left: 0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, "/timesheet",arguments: ListTimeSheetArguments(drawerWidth: drawerWidth,selectedDestination: 3));
                                  // Navigator.pushReplacementNamed(context, "/wbs");
                                },
                                leading:  SizedBox(width: 40,child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(Icons.timelapse_outlined,color: _selectedDestination==3? Colors.black:Colors.white),
                                ),),
                                title:    Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 10),
                                  child: Text(
                                    drawerWidth == 60 ? '' : 'Time Sheet',
                                    style:  TextStyle(fontSize: 17,color: _selectedDestination==3? Colors.black:Colors.white),

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),


                      drawerWidth==60?
                      InkWell(
                        hoverColor: mHoverColor,
                        onTap: (){
                          setState(() {
                            drawerWidth = 200;
                          });
                        },
                        child: SizedBox(height: 40,
                          child: Icon(Icons.supervised_user_circle_sharp,
                            color: _selectedDestination == 4 ? Colors.black: Colors.white,),
                        ),
                      ):
                      MouseRegion(
                        onHover: (event){
                          setState((){
                            homeHovered=true;
                          });
                        },
                        onExit: (event){
                          setState(() {
                            homeHovered=false;
                          });

                        },
                        child: Padding(
                          padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 4),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==4 ? Colors.white:Colors.transparent,),

                            child: ListTileTheme(
                              contentPadding: const EdgeInsets.only(left: 0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, "/createUsers",arguments: CreateUsersArguments(drawerWidth: drawerWidth,selectedDestination: 4));
                                },
                                leading:  SizedBox(width: 40,child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(Icons.supervised_user_circle_sharp,color: _selectedDestination==4? Colors.black:Colors.white),
                                ),),
                                title:    Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 10),
                                  child: Text(
                                    drawerWidth == 60 ? '' : 'User Management',
                                    style:  TextStyle(fontSize: 17,color: _selectedDestination==4? Colors.black:Colors.white),

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),


                      // /// Attendance
                      // drawerWidth==60?
                      // InkWell(
                      //   hoverColor: mHoverColor,
                      //   onTap: (){
                      //     setState(() {
                      //       drawerWidth = 200;
                      //     });
                      //   },
                      //   child: SizedBox(height: 40,
                      //     child: Icon(Icons.auto_graph_rounded,
                      //       color: _selectedDestination == 4 ? Colors.black: Colors.white,),
                      //   ),
                      // ):
                      // MouseRegion(
                      //   onHover: (event){
                      //     setState((){
                      //       homeHovered=true;
                      //     });
                      //   },
                      //   onExit: (event){
                      //     setState(() {
                      //       homeHovered=false;
                      //     });
                      //
                      //   },
                      //   child: Padding(
                      //     padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 4),
                      //     child: Container(
                      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==4 ? Colors.white:Colors.transparent,),
                      //
                      //       child: ListTileTheme(
                      //         contentPadding: const EdgeInsets.only(left: 0),
                      //         child: ListTile(
                      //           onTap: () {
                      //             // Navigator.pushReplacementNamed(context, "/wbs");
                      //           },
                      //           leading:  SizedBox(width: 40,child: Padding(
                      //             padding: const EdgeInsets.only(left: 4.0),
                      //             child: Icon(Icons.auto_graph_rounded,color: _selectedDestination==4? Colors.black:Colors.white),
                      //           ),),
                      //           title:    Padding(
                      //             padding: const EdgeInsets.only(left: 8.0,right: 10),
                      //             child: Text(
                      //               drawerWidth == 60 ? '' : 'Attendance',
                      //               style:  TextStyle(fontSize: 17,color: _selectedDestination==4? Colors.black:Colors.white),
                      //
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //
                      //
                      // /// Report
                      // drawerWidth==60?
                      // InkWell(
                      //   hoverColor: mHoverColor,
                      //   onTap: (){
                      //     setState(() {
                      //       drawerWidth = 200;
                      //     });
                      //   },
                      //   child: SizedBox(height: 40,
                      //     child: Icon(Icons.add_chart_outlined,
                      //       color: _selectedDestination == 5 ? Colors.black: Colors.white,),
                      //   ),
                      // ):
                      // MouseRegion(
                      //   onHover: (event){
                      //     setState((){
                      //       homeHovered=true;
                      //     });
                      //   },
                      //   onExit: (event){
                      //     setState(() {
                      //       homeHovered=false;
                      //     });
                      //
                      //   },
                      //   child: Padding(
                      //     padding:  const EdgeInsets.only(left: 14,right: 14,bottom: 4,top: 4),
                      //     child: Container(
                      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:_selectedDestination==5 ? Colors.white:Colors.transparent,),
                      //
                      //       child: ListTileTheme(
                      //         contentPadding: const EdgeInsets.only(left: 0),
                      //         child: ListTile(
                      //           onTap: () {
                      //             // Navigator.pushReplacementNamed(context, "/wbs");
                      //           },
                      //           leading:  SizedBox(width: 40,child: Padding(
                      //             padding: const EdgeInsets.only(left: 4.0),
                      //             child: Icon(Icons.add_chart_outlined,color: _selectedDestination==5? Colors.black:Colors.white),
                      //           ),),
                      //           title:    Padding(
                      //             padding: const EdgeInsets.only(left: 8.0,right: 10),
                      //             child: Text(
                      //               drawerWidth == 60 ? '' : 'Reports',
                      //               style:  TextStyle(fontSize: 17,color: _selectedDestination==5? Colors.black:Colors.white),
                      //
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),




                    ],
                  ),
                ),
              ),


            ),
          );
        }
    );
  }

  void selectDestination(double index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}







