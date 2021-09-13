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
}
