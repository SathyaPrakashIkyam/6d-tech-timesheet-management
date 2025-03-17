import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartData extends StatefulWidget {
  const BarChartData({Key? key}) : super(key: key);

  @override
  State<BarChartData> createState() => _BarChartDataState();
}

class _BarChartDataState extends State<BarChartData> {
  late TooltipBehavior _tooltipBehavior;


  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true,animationDuration: 1);
    super.initState();
  }
  final List<ChartData> chartData = [
    ChartData('Jan', 25, const Color.fromRGBO(9,0,136,1)),
    ChartData('Feb', 38, const Color.fromRGBO(147,0,119,1)),
    ChartData('Mar', 34, const Color.fromRGBO(228,0,124,1)),
    ChartData('April', 34, const Color.fromRGBO(228,0,124,1)),
    ChartData('May', 23, const Color.fromRGBO(228,0,124,1)),
    ChartData('Jun', 33, const Color.fromRGBO(228,0,124,1)),
    ChartData('July', 33, const Color.fromRGBO(228,0,124,1)),
    ChartData('Aug', 28, const Color.fromRGBO(228,0,124,1)),
    ChartData('Sep', 90, const Color.fromRGBO(228,0,124,1)),
    ChartData('Nov', 31, const Color.fromRGBO(228,0,124,1)),
    ChartData('Dec', 12, const Color.fromRGBO(228,0,124,1)),

  ];

  final List<ChartData> chartData2 = [
    ChartData('Jan', 60, const Color.fromRGBO(9,0,136,1)),
    ChartData('Feb', 32, const Color.fromRGBO(147,0,119,1)),
    ChartData('Mar', 41, const Color.fromRGBO(228,0,124,1)),
    ChartData('April', 31, const Color.fromRGBO(228,0,124,1)),
    ChartData('May', 41, const Color.fromRGBO(228,0,124,1)),
    ChartData('Jun', 51, const Color.fromRGBO(228,0,124,1)),
    ChartData('Jun', 33, const Color.fromRGBO(228,0,124,1)),
    ChartData('July', 33, const Color.fromRGBO(228,0,124,1)),
    ChartData('Aug', 24, const Color.fromRGBO(228,0,124,1)),
    ChartData('Sep', 77, const Color.fromRGBO(228,0,124,1)),
    ChartData('Nov', 35, const Color.fromRGBO(228,0,124,1)),
    ChartData('Dec', 12, const Color.fromRGBO(228,0,124,1)),

  ];

  @override
  Widget build(BuildContext context) {
    return  SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      isTransposed: true,
      primaryXAxis: CategoryAxis(),
      enableAxisAnimation: true,
      series: <ChartSeries>[
        BarSeries<ChartData, String>(color: const Color(0xff0063B2),
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
        ),
        BarSeries<ChartData, String>(
          color:  const Color(0xffc4bebe),
          dataSource: chartData2,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
        ),
      ],
    );
  }
}


class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}


class PirChartData extends StatefulWidget {
  const PirChartData({Key? key}) : super(key: key);

  @override
  State<PirChartData> createState() => _PirChartDataState();
}

class _PirChartDataState extends State<PirChartData> {

  late TooltipBehavior _tooltipBehavior;

  final List<ChartData> chartData = [
    ChartData('Completed', 70,  const Color.fromRGBO(0,37, 150, 190)),
    ChartData('In-Progress', 38, const Color.fromRGBO(147,0,119,1)),
    ChartData('Over Due', 34, const Color.fromRGBO(228,0,124,1)),

  ];

  @override
  void initState() {

    _tooltipBehavior = TooltipBehavior(enable: true,animationDuration:1 );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
            enableTooltip: true,
            dataSource: chartData,
            pointColorMapper:(ChartData data,  _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelSettings: DataLabelSettings(isVisible: true,
              builder: (data, point, series, pointIndex, seriesIndex) {
                return Text("${data.x}",style: const TextStyle(color: Colors.white,fontSize: 12),);
              },
            )
        ),


      ],
    );
  }
}



class WbsPriorityChart extends StatelessWidget {
  const WbsPriorityChart({super.key});

  Widget _buildProgressBar(String title, int value, int total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('$value/$total'),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value / total,
          backgroundColor: Colors.blue[100],
          color: Colors.blue,
          minHeight: 6,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: _buildProgressBar('High', 5, 10),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: _buildProgressBar('Medium', 7, 20),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: _buildProgressBar('Low', 5, 10),
          ),
        ],
      ),
    );
  }
}


