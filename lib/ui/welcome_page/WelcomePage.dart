import 'package:bangplasmartapp/ui/RouteSum/main_sum.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new MenuPage(),
        title: Text(
          'Bangpla Smart App',
          style: TextStyle(fontFamily: 'Prompt', fontSize: 20.0),
        ),
        image: Image.asset('assets/images/logo-white-bangpla.jpg'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(color: Colors.deepPurple),
        photoSize: 100.0,
        loaderColor: Colors.pinkAccent);
  }
}