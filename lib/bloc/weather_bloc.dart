import 'dart:async';

import 'package:bloc/bloc.dart';
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
  WeatherBloc(WeatherState initialState, this.weatherRepo, this.geoRepo)
      : super(initialState);

  final WeatherRepo weatherRepo;
  final GeoRepo geoRepo;

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
        WeatherState oldState = state;
        WeatherResponce weather =
            await weatherRepo.fetchWeatherData(oldState.lat, oldState.lon);
        yield state.copyWith(
          weather: weather,
          cityName: oldState.cityName,
          lat: oldState.lat,
          lon: oldState.lon,
          weatherStatus: WeatherLoaded(),
        );
      } catch (_) {
        yield state.copyWith(weatherStatus: WeatherLoadedFail());
      }
    }
  }
}
