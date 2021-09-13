import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/bloc/weather_status.dart';
import 'package:weather_app/model/city.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/repo/geo_repo.dart';
import 'package:weather_app/repo/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo weatherRepo;
  final GeoRepo geoRepo;

  WeatherBloc(this.weatherRepo, this.geoRepo) : super(WeatherState());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeatherData) {
      yield state.copyWith(weatherStatus: WeatherIsLoading());
      try {
        City city = await geoRepo.fetchDataByCityName(event._city);
        WeatherResponce weather =
            await weatherRepo.fetchWeatherData(city.lat!, city.lon!);
        yield state.copyWith(
          weather: weather,
          cityName: city.localNames!.ascii,
          lat: city.lat!,
          lon: city.lon,
          weatherStatus: WeatherLoaded(),
        );
      } catch (_) {
        yield state.copyWith(weatherStatus: WeatherLoadedFail());
      }
    } else if (event is ResetWeather) {
      yield state.copyWith(weatherStatus: WeatherIsNotSearched());
    } else if (event is RefreshWeather) {
      yield state.copyWith(weatherStatus: WeatherIsLoading());
      try {
        WeatherResponce weather =
            await weatherRepo.fetchWeatherData(state.lat, state.lon);
        yield state.copyWith(
          weather: weather,
          weatherStatus: WeatherLoaded(),
        );
      } catch (_) {
        yield state.copyWith(weatherStatus: WeatherLoadedFail());
      }
    }
  }
}
