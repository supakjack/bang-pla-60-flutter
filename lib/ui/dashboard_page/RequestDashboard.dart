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

// variable data
final title01 = 'งบประมาณคงคลัง (พ่อง ทำเองดิสัส)';
final data01 = '1K (พ่อง)';

final title02 = 'ห้ามตั้งยางเกิน (พ่อง)';
final data02 = '2K(พ่อง)';

final title03 = 'จำนวนคำร้อง';
final data03 = '68.7M';

final title04 = 'Queue online';
final data04 = '48.6M';

final title05 = 'ผู้ใช้';
final data05 = '25.5M';
// variable data

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

class RequestDashboard extends StatefulWidget {
  RequestDashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<RequestDashboard> {
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

  final List<List<double>> charts = [
    [
      1.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ]
  ];

  static final List<String> chartDropdownItems = [
    'Last 7 days',
    'Last month',
    'Last year'
  ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;

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
        title: Text('RequestDashboard',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 30.0)),
        // actions: <Widget>[
        //   Container(
        //     margin: EdgeInsets.only(right: 8.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: <Widget>[
        //         Text('beclothed.com',
        //             style: TextStyle(
        //                 color: Colors.blue,
        //                 fontWeight: FontWeight.w700,
        //                 fontSize: 14.0)),
        //         Icon(Icons.arrow_drop_down, color: Colors.black54)
        //       ],
        //     ),
        //   )
        // ],
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
                        Text(title01,
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 16.0)),
                        Text(
                          data01,
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
                          child: Icon(Icons.local_atm,
                              color: Colors.white, size: 30.0),
                        )))
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title02,
                            style:
                                TextStyle(color: Colors.green, fontSize: 16.0),
                          ),
                          Text(
                            data02,
                            style: TextStyle(
                              fontSize: 30.0,
                            ),
                          ),
                        ],
                      ),
                      DropdownButton(
                        isDense: true,
                        value: actualDropdown,
                        onChanged: (String value) => setState(() {
                          actualDropdown = value;
                          actualChart = chartDropdownItems
                              .indexOf(value); // Refresh the chart
                        }),
                        items: chartDropdownItems.map((String title) {
                          return DropdownMenuItem(
                            value: title,
                            child: Text(
                              title,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                  ),
                  Sparkline(
                    data: charts[actualChart],
                    lineWidth: 5.0,
                    lineColor: Colors.greenAccent,
                  )
                ],
              ),
            ),
            onTap: () {
              // Navigator.pushNamed(context, '/complainList');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => Name(),
                ),
              );
            },
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
                          'คำร้องที่ยังไม่ได้ดำเนินการ',
                          style: TextStyle(color: Colors.red, fontSize: 16.0),
                        ),
                        FutureBuilder<Complian>(
                          future: futureComplian,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data.cdaAc,
                                style: TextStyle(
                                  fontSize: 30.0,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                "${snapshot.error}",
                                style: TextStyle(
                                  fontSize: 30.0,
                                ),
                              );
                            }

                            // By default, show a loading spinner.
                            return CircularProgressIndicator();
                          },
                        ),
                      ],
                    ),
                    Material(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(24.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.report_problem,
                            color: Colors.white, size: 30.0),
                      )),
                    )
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.5),
            child: myCircularItems(title03, data03),
          ),
          Padding(
            padding: const EdgeInsets.all(7.5),
            child: myTextItems(title04, data04),
          ),
          Padding(
            padding: const EdgeInsets.all(7.5),
            child: myTextItems(title05, data05),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(15.0),
              // child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.max,
              // children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text(
              //           'จำนวนผู้เข้าใช้บริการ',
              //           style:
              //               TextStyle(color: Colors.green, fontSize: 16.0),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // Padding(
              //   padding: EdgeInsets.only(bottom: 4.0),
              // ),
              // Padding(
              //   padding: EdgeInsets.all(50.0),
              child: new DatumLegendWithMeasuresRequest.withRandomData(),
              // ),
              //   ],
              // ),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: new StackedAreaCustomColorLineChart.withRandomData(),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: new VerticalBarLabelChart.withRandomData(),
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
