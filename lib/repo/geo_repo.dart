import 'package:weather_app/model/city.dart';
import 'package:weather_app/services/geo_service.dart';

class GeoRepo {
  final _geoService = GeoService();

  Future<City> fetchDataByCityName(String city) => _geoService.fetchCity(city);
}
