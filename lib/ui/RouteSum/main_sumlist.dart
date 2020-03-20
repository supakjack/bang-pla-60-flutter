import 'package:bangplasmartapp/main.dart';
import 'package:bangplasmartapp/ui/RouteSum/model/MenuRequestList.dart';
import 'package:flutter/material.dart';


class SumPageList extends StatelessWidget {
  final VoidCallback callback;
  final SumRequestList sumRequestListData;
  final AnimationController animationController;
  final Animation animation;

  const SumPageList({Key key, this.sumRequestListData, this.animationController, this.animation, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
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
                            width: 48,
                          ),
                          Expanded(
                            child: Container(
                              decoration: new BoxDecoration(
                                color: HexColor('#F8FAFB'),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    //width: 48 + 24.0,
                                     //height: 20 + 24.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 18),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 10,bottom: 5, left: 50),
                                              child: Text(
                                                sumRequestListData.titleTxt,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                              ),
                                              ),
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
                    // Container(
                    //   child: Padding(
                    //     padding:
                    //         const EdgeInsets.only(top: 10,bottom: 10,left: 20),
                    //     child: Container(
                    //       width: 80,
                    //       height: 70,
                    //       decoration: BoxDecoration(
                    //         boxShadow: <BoxShadow>[
                    //           BoxShadow(
                    //               color: BangplaAppTheme.grey
                    //                   .withOpacity(0.2),
                    //               offset: Offset(0.0, 0.0),
                    //               blurRadius: 6.0),
                    //         ],
                    //       ),
                    //       child: ClipRRect(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(16.0)),
                    //           child: AspectRatio(
                    //               aspectRatio: 1.0,
                    //               child: Image.asset(complainRequestListData.imagePath)
                    //               ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
}
