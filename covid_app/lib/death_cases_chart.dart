import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'death_cases_series.dart';

class CasesChart extends StatelessWidget {
  final List<CasesSeries> data;

  CasesChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<CasesSeries, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (CasesSeries series, _) => series.day,
          measureFn: (CasesSeries series, _) => series.covid_death_cases,
          colorFn: (CasesSeries series, _) => series.barColor
      )
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Text(
                "Covid-19 Cases by Date",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
