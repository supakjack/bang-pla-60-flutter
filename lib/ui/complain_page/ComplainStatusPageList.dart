import 'package:auto_size_text/auto_size_text.dart';
import 'package:bangplasmartapp/main.dart';
import 'package:bangplasmartapp/ui/complain_page/model/ComplainRequestList.dart';
import 'package:flutter/material.dart';

class StatusPageList extends StatelessWidget {
  final VoidCallback callback;
  final StatusRequest statusRequestData;
  final AnimationController animationController;
  final Animation animation;

  const StatusPageList({Key key, this.statusRequestData, this.animationController, this.animation, this.callback}) : super(key: key);

   String _setImage() {
  String cdtId = "${statusRequestData.cdt_id}";

  if(cdtId == "23") {
    return "assets/images/complain/dispute.jpg";
  } else if(cdtId == "24") {
    return "assets/images/complain/government.jpg";
  } else if(cdtId == "28") {
    return "assets/images/complain/flood.jpg";
  } else if(cdtId == "29") {
    return "assets/images/complain/fire.jpg";
  } else if(cdtId == "32") {
    return "assets/images/complain/strom.jpg";
  } else if(cdtId == "37") {
    return "assets/images/complain/conflict.jpg";
  } else if(cdtId == "38") {
    return "assets/images/complain/minister.jpg";
  } else{
    return "assets/images/complain/minister.jpg";
  }

  // print("_mTitle: $_mTitle");  // works
  // print("_backgroundImage: $_backgroundImage"); // works
}


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 20, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  callback();
                },
                child: SizedBox(
                  width: 180,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 28,
                            ),
                            Expanded(
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: HexColor('#F8FAFB'),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey[900],
                                        offset: Offset(0, 2),
                                        blurRadius: 4.0),
                                  ],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    // SizedBox(
                                    //     //width: 48 + 24.0,
                                    //     //height: 20 + 24.0,
                                    //     ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0, bottom: 10, left: 17),
                                        child: Container(
                                          width: 80,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0)),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.grey[900],
                                                offset: Offset(0, 5),
                                                blurRadius: 10,
                                                spreadRadius: -5,
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0)),
                                            // BorderRadius.only(topRight: Radius.circular(16)),
                                            child: AspectRatio(
                                                aspectRatio: 1.0,
                                                child: Image.asset(_setImage())),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 8, bottom: 18),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(top: 10,bottom: 5,left: 0,right: 5),
                                                child: AutoSizeText(
                                                  statusRequestData.cdt_text,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 22,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5, left: 0),
                                                child: Text(
                                                  statusRequestData.cda_text,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.8)),
                                                ),
                                              ),
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      // formattedDate,
                                                      "สถานะ : ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black.withOpacity(0.8)),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      child: _getIconstatusColor(),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      statusRequestData.cds_text,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black.withOpacity(0.8)),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _getIconstatusColor() {
    if (statusRequestData.cds_text == 'ไม่ดำเนินการ')
      return Icon(Icons.brightness_1,color: Colors.yellow,size: 20);
    else if (statusRequestData.cds_text == 'ดำเนินการเสร็จสิ้น')
      return Icon(Icons.brightness_1,color: Colors.green,size: 20);
    else if (statusRequestData.cds_text == 'อนุมัติ')
      return Icon(Icons.brightness_1,color: Colors.green,size: 20);
    else if (statusRequestData.cds_text == 'ไม่อนุมัติ')
      return Icon(Icons.brightness_1,color: Colors.red,size: 20);
    else if (statusRequestData.cds_text == 'รออนุมัติ')
      return Icon(Icons.brightness_1,color: Colors.yellow,size: 20);
    else
      return Icon(Icons.brightness_1,color: Colors.red,size: 20);
  }
}


