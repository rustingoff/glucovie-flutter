import '../../../models/glucose.dart';
import 'individual_bar.dart';

class BarData {
  static List<GlucoseLevel> data = [];
  List<IndividualBar> barData = [];


  BarData(){
    barData = [
      IndividualBar(x: data[0].day, y: data[0].level),
      IndividualBar(x: data[1].day, y: data[1].level),
      IndividualBar(x: data[2].day, y: data[2].level),
      IndividualBar(x: data[3].day, y: data[3].level),
      IndividualBar(x: data[4].day, y: data[4].level),
      IndividualBar(x: data[5].day, y: data[5].level),
      IndividualBar(x: data[6].day, y: data[6].level),
    ];
  }

  List<IndividualBar> getBarData() {
    return barData;
  }
}