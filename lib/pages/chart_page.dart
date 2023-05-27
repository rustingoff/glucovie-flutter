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
  @override
  void dispose() {
    super.dispose();
  }

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
      body: const Center(
        child: SizedBox(
          height: 400,
          child: MyBarGraph(),
        ),
      ),

      bottomNavigationBar: navigation(context),
    );
  }
}
