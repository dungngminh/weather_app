import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/weather_viewmodel.dart';
import 'package:weather_app/views/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => WeatherViewModel(),
          ),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
