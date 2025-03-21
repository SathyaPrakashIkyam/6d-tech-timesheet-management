

import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api/get_api.dart';
import '../utils/customAppBar.dart';
import '../utils/customDrawer.dart';


class Dashboard extends StatefulWidget {


  const Dashboard({Key? key}) : super(key: key);
  // static String homeRoute = "/home";

  @override
  State <Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double drawerWidth =200;

  getInitialData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if(prefs.getString('role')=="Admin") {

      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getInitialData();
  }
  Map snap ={};

  @override
  Widget build(BuildContext context) {
    //return AddNewPurchaseOrder(drawerWidth: 180,selectedDestination: 4.2,);
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),

      drawer: AppBarDrawer(drawerWidth: drawerWidth,selectedDestination: 0),
      body: Row(
        children: [
          CustomDrawer(drawerWidth,0),

          const Expanded(child: HomeScreen()),
        ],
      ),
    );
  }


}

class HomeScreen extends StatefulWidget {

  const HomeScreen( {Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {




  @override
  Widget build(BuildContext context) {

    return Scaffold(
       body: SingleChildScrollView(controller: ScrollController(),
        child: Padding(
          padding: const EdgeInsets.only(left: 40,right: 40),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
               Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text( window.sessionStorage["userType"]=="Manager" ?"Project Expenses" :"Project Details",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ),
              // const SizedBox(height: 12,),
              // Row(
              //   children:  [
              //     Expanded(child: InkWell(
              //
              //       onTap: (){
              //
              //       },
              //       child:  const KpiCard(title: "Total WBS",subTitle:'300',subTitle2: "134",icon:Icons.account_balance_wallet_outlined),
              //
              //     )),
              //     const SizedBox(width: 40),
              //     Expanded(child: InkWell(
              //       //mouseCursor: MouseCursor.,
              //         customBorder: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         onTap: (){
              //
              //         },
              //         child:  const KpiCard(title: "IN-Progress WBS",subTitle:'300',subTitle2: "134",icon:Icons.account_balance_wallet_outlined),
              //
              //     )),
              //     const SizedBox(width: 40),
              //     Expanded(child: InkWell(
              //       //mouseCursor: MouseCursor.,
              //       customBorder: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       onTap: (){
              //
              //       },
              //       child:  const KpiCard(title: "Completed WBS",subTitle:'300',subTitle2: "134",icon:Icons.account_balance_wallet_outlined),
              //
              //     )),
              //     const SizedBox(width: 40),
              //     Expanded(child: InkWell(
              //       //mouseCursor: MouseCursor.,
              //       customBorder: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       onTap: (){
              //
              //       },
              //       child:  const KpiCard(title: "Over Due WBS",subTitle:'300',subTitle2: "134",icon:Icons.account_balance_wallet_outlined),
              //
              //     )),
              //     const SizedBox(width: 40),
              //
              //   ],
              // ),
              const SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3,
                    child: Column(
                      children: [
                        Card(elevation: 0,
                          child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),

                            child:
                             Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 14,),

                                SizedBox(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:window.sessionStorage["userType"]=="Manager" ? const ManagerView() : const EmployeeView(),
                                )),
                              ],
                            ),
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Card(
                        //         elevation: 8,
                        //         child: Container(
                        //           height: 400,
                        //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                        //           child:  const Column(crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               SizedBox(height: 14,),
                        //               Padding(
                        //                 padding: EdgeInsets.only(left: 18.0),
                        //                 child: Text("WBS Priority"),
                        //               ),
                        //               SizedBox(height: 20,),
                        //               SizedBox(
                        //                 height: 300,
                        //                 child: WbsPriorityChart(),
                        //
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Card(elevation: 8,
                        //         child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                        //           height: 400,
                        //           child:
                        //           const Column(crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               SizedBox(height: 14,),
                        //               Padding(
                        //                 padding: EdgeInsets.only(left: 18.0),
                        //                 child: Text("WBS Progress"),
                        //               ),
                        //               SizedBox(height: 350,child: PirChartData()),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40,),
                  // Expanded(flex: 2,
                  //   child: Card(elevation: 8,
                  //     child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                  //       height: 800,
                  //       child:   const Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           SizedBox(height: 14,),
                  //           Padding(
                  //             padding: EdgeInsets.only(left: 18.0),
                  //             child: Text("Recent WBS",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                  //           ),
                  //           SizedBox(height: 14,),
                  //           Expanded(
                  //             child: SingleChildScrollView(
                  //               child: Column(
                  //                 children: [
                  //                   RecentWBS(),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                ],
              ),
              const SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }
}


class EmployeeView extends StatefulWidget {
  const EmployeeView({super.key});

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  List displayProjectListItems = [];
  List displayWBSListItems = [];


  getProjectList() async{
    String url = "https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/projectcreation/get_all_Projects_By_user_id/USER_00090";

    var response = await getData(context: context,url: url);
    if (response != null) {
      displayProjectListItems = response;
      setState(() {

      });
    } else {
      log('---- Failed to fetch project list ----');
    }
  }
  getWBSList() async{
    String url = "https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/wbs/get_WBSList_by_user_id/USER_00090";

    var response = await getData(context: context,url: url);
    if (response != null) {
      displayWBSListItems = response;
      setState(() {

      });
    } else {
      log('---- Failed to fetch WBS list ----');
    }
  }
  List mergedList = [];

  void mergeLists() {
    mergedList = displayProjectListItems.map((project) {
      List relatedWBS = displayWBSListItems
          .where((wbs) => wbs['project_name'].trim() == project['project_name'].trim())
          .toList();

      return {
        ...project,
        "wbs_list": relatedWBS,
      };
    }).toList();
  }

  void fetchData() async {
    await getProjectList();
    await getWBSList();
    mergeLists();
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {

    return   Column(
      children: [
        ListView.builder(
            itemCount: mergedList.length,
            shrinkWrap: true,
            itemBuilder: (context, projectIndex) {
              int projectListCount = mergedList[projectIndex]["wbs_list"].length;


              var project = mergedList[projectIndex];
              List wbsList = project["wbs_list"];
              return Card(
                elevation: 10,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(project['project_name'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text("WBS : "),
                                Text(projectListCount.toString(),style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Total Hr's Spent :"),
                                Text("",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 100,)

                        ],
                      ),
                      const SizedBox(height: 5,),
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("WBS List",style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      ListView.builder(
                        itemCount: wbsList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, wbsIndex) {
                            var wbsItem = wbsList[wbsIndex];
                            Color priHigh = Colors.green;
                            Color priMedium = Colors.orange;
                            Color priLow = Colors.red;
                            String priority = wbsItem['priority'];
                            String status = wbsItem['status'];
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 2,top: 8,bottom: 8),
                                      child: SizedBox(width: 200,
                                        child: Row(
                                          children: [
                                            Text(wbsItem["wbs_id"])
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  const EdgeInsets.only(left: 3.0),
                                      child: SizedBox(width: 200,
                                        child: Row(
                                          children: [
                                            const Text("Status :"),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0,right: 8),
                                              child: Text(wbsItem["status"],style: TextStyle(fontWeight: FontWeight.bold,color: status == "Completed" ? priHigh : status == "Ongoing" ? priMedium : priLow),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:  EdgeInsets.only(left: 3.0),
                                      child: SizedBox(width: 200,
                                        child: Row (
                                          children: [
                                            Text("Hrs :"),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.0,right: 8),
                                              child: Text("",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                     Padding(
                                      padding:  const EdgeInsets.only(left: 3.0),
                                      child: SizedBox(width: 200,
                                        child: Row (
                                          children: [
                                            const Text("End Date :"),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0,right: 8),
                                              child: Text(wbsItem["end_date"],style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: SizedBox(width: 250,
                                        child: Row(
                                          children: [
                                            // const Text("WBS Members :"),
                                            Builder(
                                                builder: (context) {
                                                  // var displayListItems =[ 'Akhil',];
                                                  return SizedBox(
                                                    height: 25,width: 100, // Set fixed height
                                                    child: Stack(
                                                      children: wbsItem['members'].asMap().entries.map<Widget>((entry) {
                                                        int i = entry.key;
                                                        String member = entry.value["member"];
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
                                                  );
                                                }
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                      ),

                    ],
                  ),
                ),
              );
            },
        ),
        const SizedBox(height: 30,),
      ],
    );
  }
}

class ManagerView extends StatefulWidget {
  const ManagerView({super.key});

  @override
  State<ManagerView> createState() => _ManagerViewState();
}

class _ManagerViewState extends State<ManagerView> {
  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        InkWell(
          onTap: (){},
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0,right: 2,top: 8,bottom: 8),
                          child: SizedBox(width: 260,
                            child: Row(
                              children: [
                                Text("Project : "),
                                Text("6D - Project1",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 150,
                            child: Row(
                              children: [
                                Text("Budget :"),
                                Text("1 Cr",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row(
                              children: [
                                Text("Avl Budget :"),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0,right: 8),
                                    child: Text("90 L",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),

                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row (
                              children: [
                                Text("Total Hr's Spent :"),
                                Text(" 40:00",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0,right: 2,top: 8,bottom: 8),
                          child: SizedBox(width: 260,
                            child: Row(
                              children: [
                                Text("Total Employees : "),
                                Text("12",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 150,
                            child: Row(
                              children: [
                                Text("Total WBS :"),
                                Text("12",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row(
                              children: [
                                Text("Status :"),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0,right: 8),
                                  child: Text("In-Progress",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row (
                              children: [

                              ],
                            ),
                          ),
                        ),

                      ],
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,),
        InkWell(
            onTap: (){},
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0,right: 2,top: 8,bottom: 8),
                          child: SizedBox(width: 260,
                            child: Row(
                              children: [
                                Text("Project : "),
                                Text("6D - Project Site",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 150,
                            child: Row(
                              children: [
                                Text("Budget :"),
                                Text("50 L",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row(
                              children: [
                                Text("Avl Budget :"),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0,right: 8),
                                  child: Text("10 L",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row (
                              children: [
                                Text("Total Hr's Spent :"),
                                Text(" 100 :00",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0,right: 2,top: 8,bottom: 8),
                          child: SizedBox(width: 260,
                            child: Row(
                              children: [
                                Text("Total Employees : "),
                                Text("7",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 150,
                            child: Row(
                              children: [
                                Text("Total WBS :"),
                                Text("19",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row(
                              children: [
                                Text("Status :"),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0,right: 8),
                                  child: Text("In-Progress",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row (
                              children: [
                                Text("Due Date :"),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0,right: 8),
                                  child: Text("12-Apr-2025",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),
            ),
          ),
        const SizedBox(height:20,),
        InkWell(
          onTap: (){},
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0,right: 2,top: 8,bottom: 8),
                          child: SizedBox(width: 260,
                            child: Row(
                              children: [
                                Text("Project : "),
                                Text("6D - Project_3",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 150,
                            child: Row(
                              children: [
                                Text("Budget :"),
                                Text("1 Cr",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row(
                              children: [
                                Text("Avl Budget :"),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0,right: 8),
                                  child: Text("90 L",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row (
                              children: [
                                Text("Total Hr's Spent :"),
                                Text(" 40:00",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0,right: 2,top: 8,bottom: 8),
                          child: SizedBox(width: 260,
                            child: Row(
                              children: [
                                Text("Total Employees : "),
                                Text("12",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 150,
                            child: Row(
                              children: [
                                Text("Total WBS :"),
                                Text("12",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row(
                              children: [
                                Text("Status :"),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0,right: 8),
                                  child: Text("In-Progress",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row (
                              children: [

                              ],
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,),
        InkWell(
          onTap: (){},
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0,right: 2,top: 8,bottom: 8),
                          child: SizedBox(width: 260,
                            child: Row(
                              children: [
                                Text("Project : "),
                                Text("6D - Project_4",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 150,
                            child: Row(
                              children: [
                                Text("Budget :"),
                                Text("1 Cr",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row(
                              children: [
                                Text("Avl Budget :"),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0,right: 8),
                                  child: Text("90 L",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row (
                              children: [
                                Text("Total Hr's Spent :"),
                                Text(" 40:00",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0,right: 2,top: 8,bottom: 8),
                          child: SizedBox(width: 260,
                            child: Row(
                              children: [
                                Text("Total Employees : "),
                                Text("12",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 150,
                            child: Row(
                              children: [
                                Text("Total WBS :"),
                                Text("12",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row(
                              children: [
                                Text("Status :"),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0,right: 8),
                                  child: Text("In-Progress",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row (
                              children: [

                              ],
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,),
        InkWell(
          onTap: (){},
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0,right: 2,top: 8,bottom: 8),
                          child: SizedBox(width: 260,
                            child: Row(
                              children: [
                                Text("Project : "),
                                Text("6D - Project_7",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 150,
                            child: Row(
                              children: [
                                Text("Budget :"),
                                Text("1 Cr",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row(
                              children: [
                                Text("Avl Budget :"),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0,right: 8),
                                  child: Text("90 L",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row (
                              children: [
                                Text("Total Hr's Spent :"),
                                Text(" 40:00",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0,right: 2,top: 8,bottom: 8),
                          child: SizedBox(width: 260,
                            child: Row(
                              children: [
                                Text("Total Employees : "),
                                Text("12",style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 150,
                            child: Row(
                              children: [
                                Text("Total WBS :"),
                                Text("12",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row(
                              children: [
                                Text("Status :"),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0,right: 8),
                                  child: Text("In-Progress",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 3.0),
                          child: SizedBox(width: 200,
                            child: Row (
                              children: [

                              ],
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,),

      ],
    );
  }
}











