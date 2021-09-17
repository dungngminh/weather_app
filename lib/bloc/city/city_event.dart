part of 'city_bloc.dart';

abstract class CityEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CityNameChanged extends CityEvent {
  final String cityName;

  CityNameChanged(this.cityName);
}

class SearchCityByName extends CityEvent {
  final String cityName;

  SearchCityByName(this.cityName);
}
