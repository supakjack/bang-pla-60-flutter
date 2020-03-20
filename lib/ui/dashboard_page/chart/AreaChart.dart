// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Example of a stacked area chart with custom area colors.
///
/// By default, the area skirt for a chart will be drawn with the same color as
/// the line, but with a 10% opacity assigned to it. An area color function can
/// be provided to override this with any custom color.
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class StackedAreaCustomColorLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaCustomColorLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory StackedAreaCustomColorLineChart.withSampleData() {
    return new StackedAreaCustomColorLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory StackedAreaCustomColorLineChart.withRandomData() {
    return new StackedAreaCustomColorLineChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<LinearData, num>> _createRandomData() {
    final random = new Random();

    final myFakeDesktopData = [
      new LinearData(0, random.nextInt(100)),
      new LinearData(1, random.nextInt(100)),
      new LinearData(2, random.nextInt(100)),
      new LinearData(3, random.nextInt(100)),
    ];

    var myFakeTabletData = [
      new LinearData(0, random.nextInt(100)),
      new LinearData(1, random.nextInt(100)),
      new LinearData(2, random.nextInt(100)),
      new LinearData(3, random.nextInt(100)),
    ];

    var myFakeMobileData = [
      new LinearData(0, random.nextInt(100)),
      new LinearData(1, random.nextInt(100)),
      new LinearData(2, random.nextInt(100)),
      new LinearData(3, random.nextInt(100)),
    ];

    return [
      new charts.Series<LinearData, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearData sales, _) => sales.year,
        measureFn: (LinearData sales, _) => sales.sales,
        data: myFakeDesktopData,
      ),
      new charts.Series<LinearData, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearData sales, _) => sales.year,
        measureFn: (LinearData sales, _) => sales.sales,
        data: myFakeTabletData,
      ),
      new charts.Series<LinearData, int>(
        id: 'Mobile',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearData sales, _) => sales.year,
        measureFn: (LinearData sales, _) => sales.sales,
        data: myFakeMobileData,
      ),
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearData, int>> _createSampleData() {
    final myFakeDesktopData = [
      new LinearData(0, 5),
      new LinearData(1, 25),
      new LinearData(2, 100),
      new LinearData(3, 75),
    ];

    var myFakeTabletData = [
      new LinearData(0, 10),
      new LinearData(1, 50),
      new LinearData(2, 200),
      new LinearData(3, 150),
    ];

    var myFakeMobileData = [
      new LinearData(0, 15),
      new LinearData(1, 75),
      new LinearData(2, 300),
      new LinearData(3, 225),
    ];

    return [
      new charts.Series<LinearData, int>(
        id: 'Desktop',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (LinearData sales, _) => sales.year,
        measureFn: (LinearData sales, _) => sales.sales,
        data: myFakeDesktopData,
      ),
      new charts.Series<LinearData, int>(
        id: 'Tablet',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (LinearData sales, _) => sales.year,
        measureFn: (LinearData sales, _) => sales.sales,
        data: myFakeTabletData,
      ),
      new charts.Series<LinearData, int>(
        id: 'Mobile',
        // colorFn specifies that the line will be green.
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        // areaColorFn specifies that the area skirt will be light green.
        areaColorFn: (_, __) =>
            charts.MaterialPalette.green.shadeDefault.lighter,
        domainFn: (LinearData sales, _) => sales.year,
        measureFn: (LinearData sales, _) => sales.sales,
        data: myFakeMobileData,
      ),
    ];
  }
}

/// Sample linear data type.
class LinearData {
  final int year;
  final int sales;

  LinearData(this.year, this.sales);
}
