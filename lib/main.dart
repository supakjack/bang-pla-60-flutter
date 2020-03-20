import 'package:flutter/material.dart';
import 'package:bangplasmartapp/ui/ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bangpla Smart App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Maitree'
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/home': (context) => MyHomePage(title: 'Bangpla'),
      },
    );
  }
}
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}