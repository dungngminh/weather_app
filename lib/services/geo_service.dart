import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weather_app/model/city.dart';

class GeoService {
  //default : us
  Future<City> fetchCity(String city) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/geo/1.0/direct?q=$city&appid=f1c9816b3cf28cee5dc50225fb091b3d');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var result = convert.jsonDecode(response.body);
      Iterable list = result;
      print(result);
      // print(City.fromJson(result));
      return list.map((e) => City.fromJson(e)).toList().first;
    } else
      throw Exception("failed to get city");
  }
}
