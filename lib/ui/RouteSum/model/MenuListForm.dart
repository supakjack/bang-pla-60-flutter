import 'package:bangplasmartapp/ui/Queue/bookingList.dart';
import 'package:bangplasmartapp/ui/complain_page/ComplainPage.dart';
import 'package:bangplasmartapp/ui/dashboard_page/Dashboard.dart';
import 'package:flutter/widgets.dart';

class MenuForm {
  Widget navigateScreen;
  String imagePath;

  MenuForm({
    this.navigateScreen,
    this.imagePath = '',
  });

  static List<MenuForm> menuForm = [
    MenuForm(
      navigateScreen: ComplainPage(),
    ),
    MenuForm(
      navigateScreen: Dashboard(),
    ),
    MenuForm(
      navigateScreen: BookingList(),
    ),

  ];
}

