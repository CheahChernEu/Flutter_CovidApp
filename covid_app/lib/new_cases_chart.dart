import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'new_cases_series.dart';

class newCasesChart extends StatelessWidget {
  final List<newCasesSeries> data;

  newCasesChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<newCasesSeries, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (newCasesSeries series, _) => series.day,
          measureFn: (newCasesSeries series, _) => series.covid_new_cases,
          colorFn: (newCasesSeries series, _) => series.barColor
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
                "Covid-19 New Cases by Date",
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
