import 'package:flutter/foundation.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CasesSeries {
  final String day;
  final int covid_death_cases;
  final charts.Color barColor;

  CasesSeries(
      {
        required this.day,
        required this.covid_death_cases,
        required this.barColor
      }
      );
}


