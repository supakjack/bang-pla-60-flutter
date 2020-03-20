
import 'package:bangplasmartapp/ui/Queue/show.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/infoqueue.dart';


class BookingListView extends StatelessWidget {
  final VoidCallback callback;
  final InfoQueueUser infoQueue;

  const BookingListView({Key key, this.infoQueue, this.callback}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
            child:
            Card(
              color: Colors.lightBlue[50],
              elevation: 10,
              child:Padding( padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 16.0, right: 16.0), child: 
                Row(children: <Widget>[
                  Expanded(child: 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          new DateFormat("EEE, d MMMM yyyy" ).format(DateTime.parse(infoQueue.qol_date)),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          infoQueue.svt_name,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[900],
                              fontWeight: FontWeight.normal,
                            )
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.blue[900],)
                ],
              ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Show(
                                callback: () {},
                                infoQueue: infoQueue, 
                                ),),
              );
            },
          ); 
  }
}




