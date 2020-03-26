/// Line chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DoubleLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DoubleLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory DoubleLineChart.withSampleData() {
    return new DoubleLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.LineRendererConfig(includePoints: true));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 120),
      new LinearSales(3, 75),
      new LinearSales(4, 5),
      new LinearSales(5, 25),
      new LinearSales(6, 120),
      new LinearSales(7, 75),
      new LinearSales(8, 5),
      new LinearSales(9, 25),
      new LinearSales(10, 120),
      new LinearSales(11, 75),
    ];

    final anotherData = [
      new LinearSales(0, 20),
      new LinearSales(1, 12),
      new LinearSales(2, 75),
      new LinearSales(3, 80),
      new LinearSales(4, 20),
      new LinearSales(5, 12),
      new LinearSales(6, 75),
      new LinearSales(7, 80),
      new LinearSales(8, 20),
      new LinearSales(9, 12),
      new LinearSales(10, 75),
      new LinearSales(11, 80),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'PerfectCell',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Freezer',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: anotherData,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
