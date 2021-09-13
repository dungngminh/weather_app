part of 'weather_bloc.dart';

class WeatherState {
  final WeatherResponce? weather;
  final String cityName;
  final double lat;
  final double lon;
  final WeatherStatus weatherStatus;

  WeatherState({
    this.weather,
    this.cityName = '',
    this.lat = 0,
    this.lon = 0,
    this.weatherStatus = const WeatherInitial(),
  });

  WeatherState copyWith(
      {WeatherResponce? weather,
      String? cityName,
      double? lat,
      double? lon,
      WeatherStatus? weatherStatus}) {
    return WeatherState(
      weather: weather,
      cityName: cityName ?? this.cityName,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      weatherStatus: weatherStatus ?? this.weatherStatus,
    );
  }

  String? get main => weather?.weather?.first?.main;

  String? get icon => weather?.weather?.first?.icon?.replaceAll('n', 'd');

  double? get temp => weather?.main?.temp;

  double? get feelsLike => weather?.main?.feelsLike;

  double? get tempMax => weather?.main?.tempMax;

  double? get tempMin => weather?.main?.tempMin;

  int? get humidity => weather?.main?.humidity;

  double? get wind => weather?.wind?.speed;

  int? get visibility => weather?.visibility;
}
