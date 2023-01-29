import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ChartFL extends StatefulWidget {
  const ChartFL({super.key});

  @override
  State<ChartFL> createState() => _ChartFLState();
}

class _ChartFLState extends State<ChartFL> {
  final dataMap = <String, double>{
    "Products": 5,
    "users": 20,
    "viseters": 30,
  };

  final colorList = <Color>[
    Colors.greenAccent,
    Colors.blue,
    Colors.yellow,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      centerText: "Data",
      legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
      ),
      chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 1,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    ),
        )
      );
  }
}
