import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'booking.dart';
import 'bookinglistview.dart';
import 'homebooking.dart';
import 'model/infoqueue.dart';
import 'package:http/http.dart' as http;

class BookingList extends StatefulWidget {
  @override
  BookingListState createState() => BookingListState();
}

class BookingListState extends State<BookingList> {
  var _title = "รายการจองคิว";
  // Widget tabBody = Container(
  //   color: Color(0xFFF2F3F8),
  // );

  List<InfoQueueUser> _infoQueue = List<InfoQueueUser>();

  Future<List<InfoQueueUser>> fetchNotes() async {
    var url =
        'http://10.80.39.17/service-bangpla/index.php/Queueonline/get_all_queue_by_user_id';
    var response = await http.get(url);

    var infoQueueUserList = List<InfoQueueUser>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        infoQueueUserList.add(InfoQueueUser.fromJson(noteJson));
      }
    }
    return infoQueueUserList;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _infoQueue.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          // leading: new IconButton(
          //   icon: new Icon(Icons.arrow_back),
          //   onPressed: () {},
          // ),
          centerTitle: true,
          title: Text(_title),
        ),
        body: Column(
          children: <Widget>[
            bookingSection(context),
            Flexible(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return BookingListView(
                    callback: () {},
                    infoQueue: _infoQueue[index],
                  );
                },
                itemCount: _infoQueue.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget bookingSection(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 125,
          height: 30,
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Color(0xFF00B6F0),
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xFF00B6F0).withOpacity(0.5),
                  offset: Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: MaterialButton(
            child: Text(
              "จองคิว",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  letterSpacing: 0.0,
                  color: Color(0xFFFFFFFF)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Booking()),
              );
            },
          ),
        ),
        Container(
          width: 24,
          height: 24,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF00B6F0),
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0xFF00B6F0).withOpacity(0.5),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
              border: new Border.all(color: Color(0xFF3A5160).withOpacity(0.2)),
            ),
            child: MaterialButton(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: Icon(
                Icons.add,
                color: Color(0xFFFFFFFF),
                size: 20,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Booking()),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

// ListView detailSection(BuildContext context) {

//   var bookingList = BookingListData.bookingList;

//   return ListView.builder(
//         itemBuilder: (context, index) {
//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     _infoQueue[index].qol_date,
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold
//                     ),
//                   ),
//                   Text(
//                     _infoQueue[index].svt_name,
//                     style: TextStyle(
//                       color: Colors.grey.shade600
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//         itemCount: _infoQueue.length,
//       );
// }

// Container(
//                           color: Color(0xFFFFFFFF),
//                           child: ListView.builder(
//                             itemCount: bookingList.length,
//                             padding: EdgeInsets.only(top: 8),
//                             scrollDirection: Axis.vertical,
//                             itemBuilder: (context, index) {
//                               var count = bookingList.length > 10 ? 10 : bookingList.length;
//                               return BookingListView(
//                                 callback: () {},
//                                 bookingData: bookingList[index],
//                               );
//                             },
//                           ),
//                         );

// Card _buildRowListView({String date, String title}){
//   return Card(child:
//      Padding( padding: EdgeInsets.all(10), child:
//       Row(children: <Widget>[
//         Expanded(child:
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(date, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
//               Text(title, style: TextStyle(fontSize: 18, color: Colors.grey[800]),)
//             ],
//           ),
//         ),
//         Icon(Icons.arrow_forward_ios)
//       ],),
//     ),
//     color: Colors.grey[300],
//   );
// }

Widget bottomBar(BuildContext context) {
  return Column(
    children: <Widget>[
      Expanded(
        child: SizedBox(),
      ),
    ],
  );
}
