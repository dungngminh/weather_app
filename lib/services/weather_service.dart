import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather.dart';

class WeatherService {
  //default : us
  Future<WeatherResponce> fetchWeatherByGeo(double lat, double lon) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=f1c9816b3cf28cee5dc50225fb091b3d');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var result = convert.jsonDecode(response.body);
      print(result);
      print(WeatherResponce.fromJson(result));
      return WeatherResponce.fromJson(result);
    } else
      throw Exception("failed to get weather data");
  }
}
