import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'model/infoqueue.dart';
import 'package:flutter/material.dart';

class Show extends StatelessWidget {
  final _title = "QR CODE";

  final VoidCallback callback;
  final InfoQueueUser infoQueue;

  const Show({Key key, this.infoQueue, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true ,
          title: Text(_title),
        ),
        body: ListView(
          children: <Widget>[ 
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 16.0, right: 16.0
              ),
              child: Column(
                children: <Widget>[ 
                  QrImage(
                    data: "boq-"+infoQueue.qol_ref,
                    version: QrVersions.auto,
                    size: 250,
                    gapless: false,
                  )
                ],
              ),
              ),
            ),
            Card(
              color: Colors.blue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              child:Padding( padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 16.0, right: 16.0), child: 
                Row(children: <Widget>[
                  Expanded(child: 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        lableTextServiceType(),
                        valueServiceType(),
                        lableTextSubType(),
                        valueSubType(),
                        lableTextDate(),
                        valueDate(),
                        lableTextTime(),
                        valueTime(),
                        lableTextStatus(),
                        valueStatus(),
                        lableTextSeq(),
                        valueSeq(),
                      ],
                    ),
                  ),
                ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget lableTextServiceType(){
    return Text(
      'การบริการหลัก',
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: 20,
        height: 1.0,
        color: Colors.blue[900]
      ),
    );
  }

   Widget valueServiceType(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:Padding( padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16.0), child: 
        Row(children: <Widget>[
          Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Text(
                    ' ${infoQueue.svt_name} ', 
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.normal,
                    )
                  ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
   }

   Widget lableTextSubType(){
    return Text(
      'การบริการรอง',
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: 20,
        height: 2.0,
        color: Colors.blue[900]
      ),
    );
  }

   Widget valueSubType(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:Padding( padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16.0), child: 
        Row(children: <Widget>[
          Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Text(
                    ' ${infoQueue.svst_name} ', 
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.normal,
                    )
                  ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
   }

   Widget lableTextDate(){
    return Text(
      'วันที่จองคิว',
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: 20,
        height: 2.0,
        color: Colors.blue[900]
      ),
    );
  }

   Widget valueDate(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:Padding( padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16.0), child: 
        Row(children: <Widget>[
          Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Text(
                    new DateFormat("dd/MM/yyyy").format(DateTime.parse(infoQueue.qol_date)), 
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.normal,
                    )
                  ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
   }

   Widget lableTextTime(){
    return Text(
      'เวลา',
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: 20,
        height: 2.0,
        color: Colors.blue[900]
      ),
    );
  }

   Widget valueTime(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:Padding( padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16.0), child: 
        Row(children: <Widget>[
          Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Text(
                    '${infoQueue.ts_time_start.substring(0, 5)} '' ถึง '' ${infoQueue.ts_time_stop.substring(0, 5)} ', 
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.normal,
                    )
                  ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
   }

   Widget lableTextStatus(){
    return Text(
      'สถานะ',
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: 20,
        height: 2.0,
        color: Colors.blue[900]
      ),
    );
  }

   Widget valueStatus(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:Padding( padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16.0), child: 
        Row(children: <Widget>[
          Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Text(
                    '${infoQueue.qus_name} ', 
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.normal,
                    )
                  ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
   }

   Widget lableTextSeq(){
    return Text(
      'ลำดับคิว',
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: 20,
        height: 2.0,
        color: Colors.blue[900]
      ),
    );
  }

   Widget valueSeq(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:Padding( padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16.0), child: 
        Row(children: <Widget>[
          Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Text(
                    '${infoQueue.qol_ref} ', 
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.normal,
                    )
                  ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
   }

}

