import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/repo/geo_repo.dart';
import 'package:weather_app/repo/weather_repo.dart';
import 'package:weather_app/views/search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: BlocProvider(
        create: (context) => WeatherBloc(WeatherRepo(), GeoRepo()),
        child: SearchScreen(),
      ),
    );
  }
}
