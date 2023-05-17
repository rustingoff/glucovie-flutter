import 'package:glucovie/pages/chart/bar_graph/bar_graph.dart';
import 'package:glucovie/pages/navigation/navigation.dart';
import 'package:flutter/material.dart';

import '../constants/text_styles.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<StatefulWidget> createState() => ChartScreenState();
}

class ChartScreenState extends State<ChartScreen> {
  List<double> weeklySummary = [
    4.40,
    2.50,
    42.42,
    10.50,
    100.20,
    88.99,
    90.10,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
            'GRAFICUL GLUCOZEI',
          style: appBarTitleTS,
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          child: MyBarGraph(
              weeklySummary: weeklySummary,
          ),
        ),
      ),

      bottomNavigationBar: navigation(context),
    );
  }
}
