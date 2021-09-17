part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchWeatherData extends WeatherEvent {
  final String city;
  final double lat;
  final double lon;
  FetchWeatherData(this.city,this.lat, this.lon);
}

class RefreshWeather extends WeatherEvent {}

class ResetWeather extends WeatherEvent {}
