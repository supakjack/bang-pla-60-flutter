import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './chart/IndexChart.dart';
import './ListComplain.dart';
import 'chart/GroupedBarChart.dart';
import 'chart/StackedFillColorBarChart.dart';
import 'chart/DoubleLineChart.dart';

//import 'shop_items_page.dart';
Future<Complian> fetchComplian() async {
  final response = [];
  // final response = await http.get(
  //     'http://10.80.39.17/service-bangpla/index.php/Complain/get_count_cda_active');

  // if (response.statusCode == 200) {
  //   // If the server did return a 200 OK response, then parse the JSON.
  //   return Complian.fromJson(json.decode(response.body));
  // } else {
  //   // If the server did not return a 200 OK response, then throw an exception.
  //   throw Exception('Failed to load complian active');
  // }
}

class Complian {
  final String cdaAc;

  Complian({this.cdaAc});

  factory Complian.fromJson(Map<String, dynamic> json) {
    return Complian(
      cdaAc: json['cda_ac'] as String,
    );
  }
}

class QueueDashboard extends StatefulWidget {
  QueueDashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<QueueDashboard> {
  Future<Complian> futureComplian;

  List<CircularStackEntry> circularData = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(700.0, Color(0xff4285F4), rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Color(0xfff3af00), rankKey: 'Q2'),
        new CircularSegmentEntry(1800.0, Color(0xffec3337), rankKey: 'Q3'),
        new CircularSegmentEntry(1000.0, Color(0xff40b24b), rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  Material myTextItems(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material myCircularItems(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: AnimatedCircularChart(
                      size: const Size(100.0, 100.0),
                      initialChartData: circularData,
                      chartType: CircularChartType.Pie,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureComplian = fetchComplian();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              //
            }),
        elevation: 2.0,
        backgroundColor: Colors.lightBlue[900],
        title: Text('QueueDashboard',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 30.0)),
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('ผู้เข้ารับบริการอาคารและสถานที่',
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 16.0)),
                        Text(
                          '46 คน',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    ),
                    Material(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.home,
                              color: Colors.white, size: 30.0),
                        )))
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: new DoubleLineChart.withSampleData(),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'ผู้เข้ารับบริการเกษตรและสหกรณ์',
                          style: TextStyle(color: Colors.red, fontSize: 16.0),
                        ),
                        Text(
                          '84 คน',
                          style: TextStyle(color: Colors.black, fontSize: 30.0),
                        )
                      ],
                    ),
                    Material(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(24.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.nature_people,
                            color: Colors.white, size: 30.0),
                      )),
                    )
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.5),
            child: myTextItems("จำนวนคิว", "68"),
          ),
          Padding(
            padding: const EdgeInsets.all(7.5),
            child: myTextItems("คิวออนไลน์", "48"),
          ),
          Padding(
            padding: const EdgeInsets.all(7.5),
            child: myTextItems("คิววอล์คอิน", "20"),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: new DatumLegendWithMeasuresQueue.withRandomData(),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: new StackedFillColorBarChart.withSampleData(),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: new GroupedBarChart.withRandomData(),
            ),
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(4, 120.0),
          StaggeredTile.extent(4, 220.0),
          StaggeredTile.extent(4, 120.0),
          StaggeredTile.extent(2, 280.0),
          StaggeredTile.extent(2, 140.0),
          StaggeredTile.extent(2, 140.0),
          StaggeredTile.extent(4, 220.0),
          StaggeredTile.extent(4, 220.0),
          StaggeredTile.extent(4, 220.0),
        ],
      ),
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
      elevation: 14.0,
      color: Colors.white,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: InkWell(
          // Do onTap() if it isn't null, otherwise do print()
          onTap: onTap != null ? () => onTap : () {},
          child: child),
    );
  }
}
