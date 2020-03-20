
import 'package:bangplasmartapp/ui/complain_page/CategoryPage.dart';
import 'package:bangplasmartapp/ui/complain_page/ComplainStatusPage.dart';
import 'package:flutter/widgets.dart';

class ComplainListForm {
  Widget navigateScreen;
  String imagePath;

  ComplainListForm({
    this.navigateScreen,
    this.imagePath = '',
  });

  static List<ComplainListForm> complaintListForm = [
    ComplainListForm(
      // navigateScreen: ComplainCategoryPage(),
      navigateScreen: CategoryPage(),
    ),
    ComplainListForm(
      navigateScreen: StatusPage(),
    ),
    // ComplainListForm(
    //   navigateScreen: DesignCourseHomeScreen(),
    // ),
    // ComplainListForm(
    //   navigateScreen: HomePage(),
    // ),
    // ComplainListForm(
    //   navigateScreen: UploadImageDemo(),
    // ),
    // ComplainListForm(
    //   navigateScreen: MyApp(),
    // ),

  ];
}

