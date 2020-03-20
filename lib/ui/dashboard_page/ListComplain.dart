import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './model/Complain.dart';

Future<List<Complain>> fetchComplain(http.Client client) async {
  final response = await client.get(
      'http://10.80.39.17/service-bangpla/index.php/Complain/get_status_all_data');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseComplain, response.body);
}

class Name extends StatefulWidget {
  Name({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListComplain(),
    );
  }
}

class ListComplain extends StatelessWidget {
  final String title;

  ListComplain({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Complain>>(
        future: fetchComplain(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ComplainList(complain: snapshot.data
                  // .where((f) => f.cds_text == "ไม่ดำเนินการ")
                  // .toList()
                  )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ComplainList extends StatelessWidget {
  final List<Complain> complain;

  ComplainList({Key key, this.complain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: complain.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 2.0,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(0, 2),
                  blurRadius: 8.0)
            ],
          ),
          // color: Colors.white,
          // elevation: 14.0,
          // borderRadius: BorderRadius.circular(5.0),
          // shadowColor: Color(0x802196F3),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(complain[index].cda_text),
              subtitle: Text(complain[index].cdoc_detail),
            ),
          ),
        );
      },
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        // color: BangplaAppTheme.buildLightTheme().backgroundColor,
        color: Colors.lightBlue[900],
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (BuildContext context) => ComplainPage2()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Color.fromRGBO(255, 255, 255, 10),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "คำร้อง",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
