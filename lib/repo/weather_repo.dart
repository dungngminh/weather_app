import 'package:weather_app/model/weather.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherRepo {
  final _weatherService = WeatherService();

  Future<WeatherResponce> fetchWeatherData(double lat, double lon) =>
      _weatherService.fetchWeatherByGeo(lat, lon);
}
