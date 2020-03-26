import 'dart:ui';
import 'package:bangplasmartapp/ui/BangplaAppTheme.dart';
import 'package:bangplasmartapp/ui/complain_page/CategoryPageList.dart';
import 'package:bangplasmartapp/ui/complain_page/ComplainForm.dart';
import 'package:bangplasmartapp/ui/complain_page/ComplainPage.dart';
import 'package:bangplasmartapp/ui/complain_page/model/ComplainRequestList.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with TickerProviderStateMixin {
  AnimationController animationController;
  var categoryRequestList = CategoryRequestList.categoryRequestList;
  ScrollController _scrollController = new ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 5));
  List<String> listnewsimage = new List();
  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
   // listnewsimage.add('assets/images/webInterFace.png');
    listnewsimage.add('assets/images/complain/maincomplain.png');
    listnewsimage.add('assets/images/complain/mainstatus.jpg');
    listnewsimage.add('assets/images/complain/news1.jpg');
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: BangplaAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          backgroundColor:
              Colors.white,
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    // getAppBarUI(),
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return getHeaderUI();
                              }, childCount: 1),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: ContestTabHeader(
                                getStatusUI(),
                              ),
                            ),
                          ];
                        },
                        body: Container(
                          color:
                              BangplaAppTheme.buildLightTheme().backgroundColor,
                          child: ListView.builder(
                            itemCount: categoryRequestList.length,
                            padding: EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var count = categoryRequestList.length > 10
                                  ? 10
                                  : categoryRequestList.length;
                              var animation = Tween(begin: 0.0, end: 1.0)
                                  .animate(CurvedAnimation(
                                      parent: animationController,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                              animationController.forward();
                              return CategoryPageList(
                                callback: () {
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            // categoryListForm[index].navigateScreen,
                                            ComplainFormInput(
                                                categoryRequestListData:
                                                    categoryRequestList[index]),
                                      ),
                                    );
                                  }
                                },
                                categoryRequestListData:
                                    categoryRequestList[index],
                                animation: animation,
                                animationController: animationController,
                              );
                            },
                          ),
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
    );
  }

  Widget getHeaderUI() {
    return Stack(
      children: <Widget>[
        
        Container(
          color: BangplaAppTheme.buildLightTheme().backgroundColor,
          child: Column(
            children: <Widget>[
              // AspectRatio(
              //   aspectRatio: 1.2,
              //   child: Image.asset('assets/images/webInterFace.png'),
              // ),
              CarouselSlider(
                aspectRatio: 1.2,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: Duration(seconds: 10),
                items: listnewsimage.map((i) {
                  return AspectRatio(
                    aspectRatio: 1.2,
                    child: Image.asset('$i'),
                  );
                }).toList(),
              )
            ],
          ),
          
        ),
        Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 10),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: BangplaAppTheme.grey.withOpacity(0.4),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
              ),
            ),
        Positioned(
          top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
          right: 35,
                          width: 60,
                height: 60,
          child: new ScaleTransition(
            alignment: Alignment.center,
            scale: new CurvedAnimation(
                parent: animationController, curve: Curves.fastOutSlowIn),
            child: Card(
              color: BangplaAppTheme.nearlyBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              elevation: 1.0,
              child: Container(
                child: Center(
                  child: Icon(
                    Icons.favorite,
                    color: BangplaAppTheme.nearlyWhite,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: SizedBox(
            width: AppBar().preferredSize.height,
            height: AppBar().preferredSize.height,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius:
                    new BorderRadius.circular(AppBar().preferredSize.height),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: BangplaAppTheme.nearlyBlack,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ComplainPage()));
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget getStatusUI() {
    final infoHeight = 364.0;
    final tempHight = (MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 10),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 0),
              child: Container(
                constraints: BoxConstraints(
                    minHeight: infoHeight,
                    maxHeight: tempHight > infoHeight ? tempHight : infoHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 18, right: 16),
                      child: Text(
                        "ยื่นคำร้องเรียน / ร้องทุกข์",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                          letterSpacing: 0.27,
                          color: BangplaAppTheme.darkerText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
         Positioned(
          top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
          right: 35,
          child: new ScaleTransition(
            alignment: Alignment.center,
            scale: new CurvedAnimation(
                parent: animationController, curve: Curves.fastOutSlowIn),
          ),
        ),
        
      ],
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: BangplaAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
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
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Explore",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  final Widget searchUI;
  ContestTabHeader(
    this.searchUI,
  );
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 55.0;

  @override
  double get minExtent => 55.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
