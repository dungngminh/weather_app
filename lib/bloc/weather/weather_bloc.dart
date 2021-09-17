import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/bloc/weather/weather_status.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/repo/geo_repo.dart';
import 'package:weather_app/repo/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo weatherRepo;

  WeatherBloc(this.weatherRepo) : super(WeatherState());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeatherData) {
      yield state.copyWith(weatherStatus: WeatherIsLoading());
      try {
        WeatherResponce weather =
            await weatherRepo.fetchWeatherData(event.lat, event.lon);
        yield state.copyWith(
          weather: weather,
          cityName: event.city,
          lat: event.lat,
          lon: event.lon,
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
          cityName: state.cityName,
          lat: state.lat,
          lon: state.lon,
          weatherStatus: WeatherLoaded(),
        );
      } catch (_) {
        yield state.copyWith(weatherStatus: WeatherLoadedFail());
      }
    }
  }
}

