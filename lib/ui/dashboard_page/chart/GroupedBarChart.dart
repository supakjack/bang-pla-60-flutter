/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedBarChart(this.seriesList, {this.animate});

  factory GroupedBarChart.withSampleData() {
    return new GroupedBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }
  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory GroupedBarChart.withRandomData() {
    return new GroupedBarChart(_createRandomData());
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('ภาษี', 5),
      new OrdinalSales('ทะเบียนพาณิชย์', 25),
      new OrdinalSales('สถานที่', 100),
      new OrdinalSales('สหกรณ์', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('ภาษี', 25),
      new OrdinalSales('ทะเบียนพาณิชย์', 50),
      new OrdinalSales('สถานที่', 10),
      new OrdinalSales('สหกรณ์', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('ภาษี', 10),
      new OrdinalSales('ทะเบียนพาณิชย์', 15),
      new OrdinalSales('สถานที่', 50),
      new OrdinalSales('สหกรณ์', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
    ];
  }

    static List<charts.Series<OrdinalSales, String>> _createRandomData() {
    final random = new Random();
    final desktopSalesData = [
      new OrdinalSales('ภาษี', random.nextInt(100)),
      new OrdinalSales('ทะเบียนพาณิชย์', random.nextInt(100)),
      new OrdinalSales('สถานที่', random.nextInt(100)),
      new OrdinalSales('สหกรณ์', random.nextInt(100)),
    ];

    final tableSalesData = [
      new OrdinalSales('ภาษี', random.nextInt(100)),
      new OrdinalSales('ทะเบียนพาณิชย์', random.nextInt(100)),
      new OrdinalSales('สถานที่', random.nextInt(100)),
      new OrdinalSales('สหกรณ์', random.nextInt(100)),
    ];

    final mobileSalesData = [
      new OrdinalSales('ภาษี', random.nextInt(100)),
      new OrdinalSales('ทะเบียนพาณิชย์', random.nextInt(100)),
      new OrdinalSales('สถานที่', random.nextInt(100)),
      new OrdinalSales('สหกรณ์', random.nextInt(100)),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}