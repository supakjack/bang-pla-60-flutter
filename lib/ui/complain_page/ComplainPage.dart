import 'package:bangplasmartapp/ui/BangplaAppTheme.dart';
import 'package:bangplasmartapp/ui/RouteSum/main_sum.dart';
import 'package:bangplasmartapp/ui/complain_page/ComplainPageList.dart';
import 'package:bangplasmartapp/ui/complain_page/model/ComplainListForm.dart';
import 'package:bangplasmartapp/ui/complain_page/model/ComplainRequestList.dart';
import 'package:flutter/material.dart';



class ComplainPage extends StatefulWidget {
  @override
  _ComplainPageState createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage> with TickerProviderStateMixin {
  AnimationController animationController;
  List<ComplainListForm> complaintListForm = ComplainListForm.complaintListForm;
  var complainRequestList = ComplainRequestList.complainRequestList;
  ScrollController _scrollController = new ScrollController();


  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    super.initState();
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
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
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
                    getAppBarUI(),
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    // getSearchBarUI(),
                                  ],
                                );
                              }, childCount: 1),
                            ),
                          ];
                        },
                        body: Container(
                          color: Colors.white,
                          
                          child: ListView.builder(
                            itemCount: complainRequestList.length,
                            padding: EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var count = complainRequestList.length > 10 ? 10 : complainRequestList.length;
                              var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                                  parent: animationController, curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn)));
                              animationController.forward();
                              return ComplainPageList(
                                callback: () {
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            complaintListForm[index].navigateScreen,
                                      ),
                                    );
                                  }
                                },
                                complainRequestListData: complainRequestList[index],
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

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        // color: BangplaAppTheme.buildLightTheme().backgroundColor,
        color: Colors.lightBlue[900],
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.withOpacity(0.2), offset: Offset(0, 2), blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 8, right: 8),
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MenuPage()));
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
                    color: BangplaAppTheme.buildLightTheme().backgroundColor,                  ),
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
