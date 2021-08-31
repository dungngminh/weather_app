import 'package:flutter/material.dart';
import 'package:weather_app/views/home_screen.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}