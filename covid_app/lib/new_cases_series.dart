import 'package:flutter/foundation.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class newCasesSeries {
  final String day;
  final int covid_new_cases;
  final charts.Color barColor;

  newCasesSeries(
      {
        required this.day,
        required this.covid_new_cases,
        required this.barColor
      }
      );
}


