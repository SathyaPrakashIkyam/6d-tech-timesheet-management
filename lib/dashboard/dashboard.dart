

import 'dart:developer';
import 'dart:html';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_management/dashboard/recent_wbs.dart';

import '../utils/api/get_api.dart';
import '../utils/customAppBar.dart';
import '../utils/customDrawer.dart';
import 'dashboard_charts.dart';
import 'kpi_card.dart';


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
  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    //return AddNewPurchaseOrder(drawerWidth: 180,selectedDestination: 4.2,);
    print('-------- dash board width ------');
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),

      drawer: AppBarDrawer(drawerWidth: drawerWidth,selectedDestination: 0),
      body: Row(
        children: [
          CustomDrawer(drawerWidth,0),

           Expanded(
              child: AdaptiveScrollbar(
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
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9 > 1600 ? MediaQuery.of(context).size.width * 0.9 : 1600,
                                  height: 1000,
                                  child: const HomeScreen()
                              )
                          )
                      )
                  )
              )
          ),
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
                                SizedBox(child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                                  child:window.sessionStorage["userType"]=="Manager" || window.sessionStorage["userType"]=="Department Head" ? const ManagerView() : const EmployeeView(),
                                )),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(width: 40,),
                 

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

  List displayProjectListItems = [];
  List displayWBSListItems = [];
  bool isLoading = true;
  getProjectList() async{
    String url = "https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/projectcreation/get_all_Projects_By_user_id/${window.sessionStorage["userId"]}";

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
    String url = "https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/wbs/get_WBSList_by_user_id/${window.sessionStorage["userId"]}";

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
    setState(() {
      isLoading = false;
    });
  }

  String formatBudget(int budget) {
    if (budget >= 10000000) {
      double crore = budget / 10000000;
      return "${crore.toStringAsFixed(1)} Cr";
    } else if (budget >= 100000) {
      double lakh = budget / 100000;
      return "${lakh.toStringAsFixed(1)} Lakhs";
    } else if (budget >= 1000) {
      double thousand = budget / 1000;
      return "${thousand.toStringAsFixed(1)} K";
    } else if (budget >= 100) {
      return "$budget";
    } else {
      return budget.toString();
    }
  }


  @override
  void initState() {
    super.initState();
    fetchData();
  }



  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [

        Row(
          children:  [
            Expanded(child: InkWell(

              onTap: (){

              },
              child:  const KpiCard(title: "Total WBS",subTitle:'5',subTitle2: "134",icon:Icons.account_balance_wallet_outlined),

            )),
            const SizedBox(width: 40),
            Expanded(child: InkWell(
              //mouseCursor: MouseCursor.,
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: (){

              },
              child:  const KpiCard(title: "IN-Progress WBS",subTitle:'4',subTitle2: "134",icon:Icons.account_balance_wallet_outlined),

            )),
            const SizedBox(width: 40),
            Expanded(child: InkWell(
              //mouseCursor: MouseCursor.,
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: (){

              },
              child:  const KpiCard(title: "Completed WBS",subTitle:'1',subTitle2: "1",icon:Icons.account_balance_wallet_outlined),

            )),
            const SizedBox(width: 40),
            Expanded(child: InkWell(
              //mouseCursor: MouseCursor.,
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: (){

              },
              child:  const KpiCard(title: "Over Due WBS",subTitle:'1',subTitle2: "1",icon:Icons.account_balance_wallet_outlined),

            )),
            const SizedBox(width: 40),

          ],
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: Card(
                elevation: 8,
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                  child:  const Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 14,),
                      Padding(
                        padding: EdgeInsets.only(left: 18.0),
                        child: Text("WBS Priority"),
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        height: 300,
                        child: BarChartData(),

                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(flex: 2,
              child: Card(elevation: 8,
                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                  height: 400,
                  child:
                   Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 14,),
                      const Padding(
                        padding: EdgeInsets.only(left: 18.0),
                        child: Text("Project List"),
                      ),
                      SizedBox(
                        height: 350,
                         child: SingleChildScrollView(
                           child: Column(
                             children: [
                               for(int i=0; i<mergedList.length;i++)
                               Column(
                                 children: [
                                   InkWell(
                                   onTap: (){
                                     print(mergedList[i]);
                                   },
                                   child:  Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Card(elevation: 10,
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Column(
                                           children: [
                                             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Padding(
                                                   padding: const EdgeInsets.only(left: 8.0,right: 2,top: 8,bottom: 8),
                                                   child: SizedBox(
                                                     width: 260,
                                                     child: Row(
                                                       children: [
                                                         const Text("Project : "),
                                                         Expanded( // This forces text to stay within bounds
                                                           child: Text(
                                                             "${mergedList[i]['project_name']}",
                                                             style: const TextStyle(fontWeight: FontWeight.bold),
                                                             overflow: TextOverflow.ellipsis, // Use ellipsis instead of clip
                                                           ),
                                                         ),
                                                       ],
                                                     ),
                                                   ),

                                                 ),

                                                 Padding(
                                                   padding: const EdgeInsets.only(left: 3.0),
                                                   child: SizedBox(width: 150,
                                                     child: Row(
                                                       children: [
                                                         const Text("Budget :"),
                                                         Text(formatBudget(mergedList[i]['budget']),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                                                       ],
                                                     ),
                                                   ),
                                                 ),

                                                 Padding(
                                                   padding:  const EdgeInsets.only(left: 3.0),
                                                   child: SizedBox(width: 200,
                                                     child: Row(
                                                       children: [
                                                         const Text("Avl Budget :"),
                                                         Padding(
                                                           padding: const EdgeInsets.only(left: 8.0,right: 8),
                                                           child: Text(formatBudget(mergedList[i]['available_budget']),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),

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
                                                         const Text("Total Hr's Spent :"),
                                                         Text("${mergedList[i]['hrs_spent']}",style: const TextStyle(fontWeight: FontWeight.bold)),
                                                       ],
                                                     ),
                                                   ),
                                                 ),

                                               ],
                                             ),
                                             const SizedBox(height: 10,),
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Padding(
                                                   padding: const EdgeInsets.only(left: 8.0,right: 2,top: 8,bottom: 8),
                                                   child: SizedBox(width: 260,
                                                     child: Row(
                                                       children: [
                                                         const Text("Total Employees : "),
                                                         Text("${mergedList[i]['members'].length}",style: const TextStyle(fontWeight: FontWeight.bold)),
                                                       ],
                                                     ),
                                                   ),
                                                 ),

                                                 Padding(
                                                   padding: const EdgeInsets.only(left: 3.0),
                                                   child: SizedBox(width: 150,
                                                     child: Row(
                                                       children: [
                                                         const Text("Total WBS :"),
                                                         Text("${mergedList[i]['wbs_list'].length}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
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
                                                           child: Text("${mergedList[i]['status']}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
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
                               )

                             ],
                           ),
                         )
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
        const SizedBox(height: 40),

        Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Card(
                elevation: 8,
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                  child:  const Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 14,),
                      Padding(
                        padding: EdgeInsets.only(left: 18.0),
                        child: Text("WBS Priority"),
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        height: 300,
                        child: WbsPriorityChart(),

                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(flex: 2,
              child: Card(elevation: 8,
                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                  height: 400,
                  child:    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 14,),
                      const Padding(
                        padding: EdgeInsets.only(left: 18.0),
                        child: Text("Recent WBS",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 14,),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              isLoading
                                  ? const Center(child: CircularProgressIndicator()) // Show loader
                                  : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    RecentWBS(wbsList: displayWBSListItems), // Rebuild after API call
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),

      ],
    );
  }
}











