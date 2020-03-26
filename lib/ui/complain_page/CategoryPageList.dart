import 'package:auto_size_text/auto_size_text.dart';
import 'package:bangplasmartapp/main.dart';
import 'package:bangplasmartapp/ui/BangplaAppTheme.dart';
import 'package:bangplasmartapp/ui/complain_page/model/ComplainRequestList.dart';
import 'package:flutter/material.dart';

class CategoryPageList extends StatelessWidget {
  final VoidCallback callback;
  final CategoryRequestList categoryRequestListData;
  final AnimationController animationController;
  final Animation animation;

  const CategoryPageList(
      {Key key,
      this.categoryRequestListData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

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
                  height: 110,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: HexColor('#97b9fc'),
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
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10, left: 17),
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
                                            child: AspectRatio(
                                                aspectRatio: 1.0,
                                                child: Image.asset(categoryRequestListData.imagePath)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 13, top: 8, bottom: 18),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 5,
                                                    left: 0),
                                                child: AutoSizeText(
                                                  categoryRequestListData.title,
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
                                                child: AutoSizeText(
                                                  categoryRequestListData.subtitle,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                          .withOpacity(0.8)),
                                                  maxLines: 1,
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
