import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glucovie/api/apiClient.dart';
import 'package:glucovie/pages/chart/bar_graph/individual_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBarGraph extends StatefulWidget {
  const MyBarGraph({Key? key}) : super(key: key);

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  final ApiClient _apiClient = ApiClient();
  final List<dynamic> data = [];
  List<IndividualBar> objs = [];

  @override
  void dispose() {
    super.dispose();
  }

  double getMaxValue() {
    double max = 0;
    for (var i = 0; i < data.length; i++) {
      double v = double.parse(data[i]["level"].toString());
      if (max < v){
        max = v;
      }
    }

    return max;
  }

  @override
  void initState() {
    super.initState();
    var response = _apiClient.getGlucoseLevelLastWeek();
    response
        .then((value) => {
              data.addAll(value.data["data"]),
              setState(() {
                setObjs();
              }),
            })
        .onError((error, stackTrace) => {
              debugPrint("${error}"),
            });
  }

  void setObjs() {
    List<IndividualBar> o = [];

    for (var v in data) {
      o.add(IndividualBar(
        x: v["day"],
        y: double.parse(v["level"].toString()),
      ));
    }

    objs.addAll(o);
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    TextStyle style = GoogleFonts.openSans(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 10,
      ),
    );

    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text("Luni", style: style);
        break;
      case 2:
        text = Text("Marți", style: style);
        break;
      case 3:
        text = Text("Miercuri", style: style);
        break;
      case 4:
        text = Text("Joi", style: style);
        break;
      case 5:
        text = Text("Vineri", style: style);
        break;
      case 6:
        text = Text("Sâmbătă", style: style);
        break;
      case 0:
        text = Text("Duminică", style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey[100],
          ),
        ),
        maxY: getMaxValue(),
        minY: 10,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles:
                SideTitles(showTitles: true, getTitlesWidget: getBottomTitles),
          ),
        ),
        barGroups: objs
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.purple,
                    width: 25,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: getMaxValue(),
                      color: Colors.purple[100],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
