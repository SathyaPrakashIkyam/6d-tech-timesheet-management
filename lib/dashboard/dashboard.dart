

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_management/dashboard/dashboard_charts.dart';
import 'package:timesheet_management/dashboard/recent_wbs.dart';

import '../utils/customAppBar.dart';
import '../utils/customDrawer.dart';
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
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
       body: SingleChildScrollView(controller: ScrollController(),
        child: Padding(
          padding: const EdgeInsets.only(left: 40,right: 40),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Dashboard",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12,),
              Row(
                children:  [
                  Expanded(child: InkWell(

                    onTap: (){

                    },
                    child:  const KpiCard(title: "Total WBS",subTitle:'300',subTitle2: "134",icon:Icons.account_balance_wallet_outlined),

                  )),
                  const SizedBox(width: 40),
                  Expanded(child: InkWell(
                    //mouseCursor: MouseCursor.,
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onTap: (){

                      },
                      child:  const KpiCard(title: "IN-Progress WBS",subTitle:'300',subTitle2: "134",icon:Icons.account_balance_wallet_outlined),

                  )),
                  const SizedBox(width: 40),
                  Expanded(child: InkWell(
                    //mouseCursor: MouseCursor.,
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: (){

                    },
                    child:  const KpiCard(title: "Completed WBS",subTitle:'300',subTitle2: "134",icon:Icons.account_balance_wallet_outlined),

                  )),
                  const SizedBox(width: 40),
                  Expanded(child: InkWell(
                    //mouseCursor: MouseCursor.,
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: (){

                    },
                    child:  const KpiCard(title: "Over Due WBS",subTitle:'300',subTitle2: "134",icon:Icons.account_balance_wallet_outlined),

                  )),
                  const SizedBox(width: 40),

                ],
              ),
              const SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(flex: 3,
                    child: Column(
                      children: [
                        Card(elevation: 8,
                          child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                            height: 400,
                            child:
                            const Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 14,),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.0,bottom: 8),
                                  child: Text("Work Activity"),
                                ),
                                SizedBox(height: 350,child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: BarChartData(),
                                )),
                              ],
                            ),
                          ),
                        ),
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
                                        child: WbsPriorityChart(),

                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(elevation: 8,
                                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                                  height: 400,
                                  child:
                                  const Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 14,),
                                      Padding(
                                        padding: EdgeInsets.only(left: 18.0),
                                        child: Text("WBS Progress"),
                                      ),
                                      SizedBox(height: 350,child: PirChartData()),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20,),
                  // Expanded(
                  //   child: Card(
                  //     elevation: 8,
                  //     child: Container(
                  //       height: 400,
                  //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                  //       child:  const Column(crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           SizedBox(height: 14,),
                  //           Padding(
                  //             padding: EdgeInsets.only(left: 18.0),
                  //             child: Text("Pie Chart"),
                  //           ),
                  //           SizedBox(height: 20,),
                  //           SizedBox(
                  //               height: 300,
                  //               child: PirChartData()
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 20,),
                  Expanded(flex: 2,
                    child: Card(elevation: 8,
                      child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                        height: 800,
                        child:   const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 14,),
                            Padding(
                              padding: EdgeInsets.only(left: 18.0),
                              child: Text("Recent WBS",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(height: 14,),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    RecentWBS(),
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
              const SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }


}




// class BarChartData extends StatefulWidget {
//   const BarChartData({Key? key}) : super(key: key);
//
//   @override
//   State<BarChartData> createState() => _BarChartDataState();
// }
//
// class _BarChartDataState extends State<BarChartData> {
//   late TooltipBehavior _tooltipBehavior;
//
//
//   @override
//   void initState() {
//     _tooltipBehavior = TooltipBehavior(enable: true,animationDuration: 1);
//     super.initState();
//   }
//   final List<ChartData> chartData = [
//     ChartData('Jan', 25, const Color.fromRGBO(9,0,136,1)),
//     ChartData('Feb', 38, const Color.fromRGBO(147,0,119,1)),
//     ChartData('Mar', 34, const Color.fromRGBO(228,0,124,1)),
//     ChartData('April', 34, const Color.fromRGBO(228,0,124,1)),
//     ChartData('May', 23, const Color.fromRGBO(228,0,124,1)),
//     ChartData('Jun', 33, const Color.fromRGBO(228,0,124,1)),
//     ChartData('Others', 52, const Color.fromRGBO(255,189,57,1))
//   ];
//
//   final List<ChartData> chartData2 = [
//     ChartData('Jan', 60, const Color.fromRGBO(9,0,136,1)),
//     ChartData('Feb', 32, const Color.fromRGBO(147,0,119,1)),
//     ChartData('Mar', 41, const Color.fromRGBO(228,0,124,1)),
//     ChartData('April', 31, const Color.fromRGBO(228,0,124,1)),
//     ChartData('May', 41, const Color.fromRGBO(228,0,124,1)),
//     ChartData('Jun', 51, const Color.fromRGBO(228,0,124,1)),
//     ChartData('Others', 22, const Color.fromRGBO(255,189,57,1))
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return  SfCartesianChart(
//       tooltipBehavior: _tooltipBehavior,
//       isTransposed: true,
//       primaryXAxis: CategoryAxis(),
//       series: <ChartSeries>[
//         BarSeries<ChartData, String>(color: const Color(0xff747AF2),
//           dataSource: chartData,
//           xValueMapper: (ChartData data, _) => data.x,
//           yValueMapper: (ChartData data, _) => data.y,
//         ),
//         BarSeries<ChartData, String>(
//           color:  const Color(0xffEF376E),
//           dataSource: chartData2,
//           xValueMapper: (ChartData data, _) => data.x,
//           yValueMapper: (ChartData data, _) => data.y,
//         ),
//       ],
//     );
//   }
// }
//
//
// class ChartData {
//   ChartData(this.x, this.y, this.color);
//   final String x;
//   final double y;
//   final Color color;
// }
//
// class _SalesData {
//   _SalesData(this.year, this.sales);
//
//   final String year;
//   final double sales;
// }
//
//
// class LineChartData extends StatefulWidget {
//   const LineChartData({Key? key}) : super(key: key);
//
//   @override
//   State<LineChartData> createState() => _LineChartDataState();
// }
//
// class _LineChartDataState extends State<LineChartData> {
//
//   List<_SalesData> data = [
//     _SalesData('Jan', 35),
//     _SalesData('Feb', 18),
//     _SalesData('Mar', 32),
//     _SalesData('Apr', 32),
//     _SalesData('May', 40),
//     _SalesData('Jun', 29)
//   ];
//
//   List<_SalesData> data2 = [
//     _SalesData('Jan', 30),
//     _SalesData('Feb', 8),
//     _SalesData('Mar', 34),
//     _SalesData('Apr', 42),
//     _SalesData('May', 45),
//     _SalesData('Jun', 39)
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SfCartesianChart(
//         primaryXAxis: CategoryAxis(),
//
//         // Chart title
//
//         // Enable legend
//
//         // Enable tooltip
//         tooltipBehavior: TooltipBehavior(enable: true),
//         series: <ChartSeries<_SalesData, String>>[
//           LineSeries<_SalesData, String>(
//               dataSource: data,
//               xValueMapper: (_SalesData sales, _) => sales.year,
//               yValueMapper: (_SalesData sales, _) => sales.sales,
//               name: 'Sales',
//               // Enable data label
//               dataLabelSettings: const DataLabelSettings(isVisible: true)),
//           LineSeries<_SalesData, String>(
//               dataSource: data2,
//               xValueMapper: (_SalesData sales, _) => sales.year,
//               yValueMapper: (_SalesData sales, _) => sales.sales,
//               name: 'Sales 2',
//               // Enable data label
//               dataLabelSettings: const DataLabelSettings(isVisible: true))
//         ]
//     );
//   }
// }
//
//
//
// class PirChartData extends StatefulWidget {
//   const PirChartData({Key? key}) : super(key: key);
//
//   @override
//   State<PirChartData> createState() => _PirChartDataState();
// }
//
// class _PirChartDataState extends State<PirChartData> {
//
//   late TooltipBehavior _tooltipBehavior;
//
//   final List<ChartData> chartData = [
//     ChartData('David', 25,  const Color.fromRGBO(0,37, 150, 190)),
//     ChartData('Steve', 38, const Color.fromRGBO(147,0,119,1)),
//     ChartData('Jack', 34, const Color.fromRGBO(228,0,124,1)),
//     ChartData('Others', 52, const Color.fromRGBO(255,189,57,1))
//   ];
//
//   @override
//   void initState() {
//
//     _tooltipBehavior = TooltipBehavior(enable: true,animationDuration:1 );
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SfCircularChart(
//       legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
//       tooltipBehavior: _tooltipBehavior,
//       series: <CircularSeries>[
//         DoughnutSeries<ChartData, String>(
//             enableTooltip: true,
//             dataSource: chartData,
//             pointColorMapper:(ChartData data,  _) => data.color,
//             xValueMapper: (ChartData data, _) => data.x,
//             yValueMapper: (ChartData data, _) => data.y,
//             dataLabelSettings: DataLabelSettings(isVisible: true,
//               builder: (data, point, series, pointIndex, seriesIndex) {
//                 return Text("${data.x}",style: const TextStyle(color: Colors.white,fontSize: 12),);
//               },
//             )
//         ),
//
//
//       ],
//     );
//   }
// }





