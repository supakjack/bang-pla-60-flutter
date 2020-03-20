import 'package:flutter/material.dart';

import 'booking.dart';

// void main() => runApp(new homebooking());

class Homebooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        platform: TargetPlatform.iOS,
      ),
      home: Booking(),
    );
  }
}