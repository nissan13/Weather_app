import 'package:flutter/material.dart';
import 'package:weather_application_2/home_page.dart';
import 'package:weather_application_2/loading_screen.dart';
import 'package:weather_application_2/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: HomePage(),
    );
  }
}
