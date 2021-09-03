import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/services/weather_service.dart';

enum LoadingStatus { idle, done }

class WeatherViewModel extends ChangeNotifier {
  var loadingStatus = LoadingStatus.idle;
  WeatherResponce? _responce = WeatherResponce();

  Future<void> fetchWeather() async {
    try {
      _responce = await WeatherService().fetchWeatherByGeo(16.0678, 108.2208);
      if (_responce != null) {
        loadingStatus = LoadingStatus.done;
      } else
        loadingStatus = LoadingStatus.idle;
      notifyListeners();
    } catch (Expection) {
      print("Weather Error");
    }
  }

  // String get main => _responce?.weather?.first?.main ?? "";
  // String get icon =>
  //     _responce?.weather?.first?.icon?.replaceAll('n', 'd') ?? "";
  // double get temp =>
  //     _responce?.main?.temp == null ? 0 : _responce!.main!.temp! - 273.15;
  // double get feelsLike => _responce?.main?.feelsLike == null
  //     ? 0
  //     : _responce!.main!.feelsLike! - 273.15;
  // double get tempMax =>
  //     _responce?.main?.tempMax == null ? 0 : _responce!.main!.tempMax! - 273.15;
  // double get tempMin =>
  //     _responce?.main?.tempMin == null ? 0 : _responce!.main!.tempMin! - 273.15;
  // int get humidity => _responce?.main?.humidity ?? 0;
  // double get wind => _responce?.wind?.speed ?? 0;
  // int get visibility => _responce?.visibility ?? 0;

  String? get main => _responce?.weather?.first?.main;
  String? get icon => _responce?.weather?.first?.icon?.replaceAll('n', 'd');
  double? get temp => _responce?.main?.temp;
  double? get feelsLike => _responce?.main?.feelsLike;
  double? get tempMax => _responce?.main?.tempMax;
  double? get tempMin => _responce?.main?.tempMin;
  int? get humidity => _responce?.main?.humidity;
  double? get wind => _responce?.wind?.speed;
  int? get visibility => _responce?.visibility;
}
