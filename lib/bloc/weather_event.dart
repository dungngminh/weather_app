part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {

  @override
    List<Object?> get props => [];
}

class FetchWeatherData extends WeatherEvent {
  final String _city;

  FetchWeatherData(this._city);

  @override
  List<Object?> get props => [_city];
}

class RefreshWeather extends WeatherEvent{
final String _city;

  RefreshWeather(this._city);

  @override
  List<Object?> get props => [_city];
}
class ResetWeather extends WeatherEvent{}