import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/city/city_status.dart';
import 'package:weather_app/model/city.dart';
import 'package:weather_app/repo/geo_repo.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final GeoRepo geoRepo;
  CityBloc(this.geoRepo) : super(CityState()){
    on<CityNameChanged>(((event, emit) async {
      emit(state.copyWith(cityStatus: CityIsSearching()));
      try {
        City city = await geoRepo.fetchDataByCityName(event.cityName);
        print(city);
        emit(state.copyWith(
          cityName: city.localNames!.ascii,
          lat: city.lat,
          lon: city.lon,
          cityStatus: CitySearched(),
        ));
      } catch (_) {
        print(false);
        emit (state.copyWith(cityStatus: CitySearchedFail()));
      }
    }));
  }


}
