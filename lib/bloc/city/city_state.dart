part of 'city_bloc.dart';

class CityState {
  final String cityName;
  final double lat;
  final double lon;
  final CityStatus cityStatus;

  CityState({
    this.cityName = '',
    this.lat = 0,
    this.lon = 0,
    this.cityStatus = const CityInitial(),
  });
  
  CityState copyWith(
      {String? cityName,
      double? lat,
      double? lon,
      CityStatus? cityStatus}) {
    return CityState(
      cityName: cityName ?? this.cityName,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      cityStatus: cityStatus ?? this.cityStatus,
    );
  }
}
