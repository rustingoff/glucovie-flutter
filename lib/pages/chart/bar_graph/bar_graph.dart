import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glucovie/pages/chart/bar_graph/bar_data.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBarGraph extends StatelessWidget {
  final List weeklySummary;
  final double maxY = 100;

  const MyBarGraph({Key? key, required this.weeklySummary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: weeklySummary[0],
      monAmount: weeklySummary[1],
      tueAmount: weeklySummary[2],
      wedAmount: weeklySummary[3],
      thurAmount: weeklySummary[4],
      friAmount: weeklySummary[5],
      satAmount: weeklySummary[6],
    );
    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles),
          ),
        ),
        barGroups: myBarData.barData
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
                      toY: maxY,
                      color: Colors.purple[200],
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

Widget getBottomTitles(double value, TitleMeta meta) {
  TextStyle style = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 10,
    ),
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text("Luni", style: style);
      break;
    case 1:
      text = Text("Marti", style: style);
      break;
    case 2:
      text = Text("Miercuri", style: style);
      break;
    case 3:
      text = Text("Joi", style: style);
      break;
    case 4:
      text = Text("Vineri", style: style);
      break;
    case 5:
      text = Text("Sâmbătă", style: style);
      break;
    case 6:
      text = Text("Duminică", style: style);
      break;
    default:
      text = Text('', style: style);
      break;
  }
  
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
