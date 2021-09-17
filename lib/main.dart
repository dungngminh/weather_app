import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/repo/geo_repo.dart';
import 'package:weather_app/repo/weather_repo.dart';
import 'package:weather_app/views/home_screen.dart';
import 'package:weather_app/views/search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => WeatherRepo(),
        ),
        RepositoryProvider(
          create: (context) => GeoRepo(),
        ),
      ],
      child: MaterialApp(
        title: 'Weather',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: '/',
        routes: {
          '/': (context) => SearchScreen(),
          'weather': (context) => HomeScreen(),
        },
      ),
    );
  }
}
