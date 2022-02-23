
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/bloc/weather/weather_status.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/repo/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo weatherRepo;

  WeatherBloc(this.weatherRepo) : super(WeatherState()) {
    on<FetchWeatherData>(((event, emit) async {
     emit(state.copyWith(weatherStatus: WeatherIsLoading()));
    try {
      WeatherResponce weather =
          await weatherRepo.fetchWeatherData(state.lat, state.lon);
      emit(state.copyWith(
        weather: weather,
        cityName: state.cityName,
        lat: state.lat,
        lon: state.lon,
        weatherStatus: WeatherLoaded(),
      ));
    } catch (_) {
      emit(state.copyWith(weatherStatus: WeatherLoadedFail()));
    }
    }));
    on<ResetWeather>(((event, emit) {
      emit(state.copyWith(weatherStatus: WeatherIsNotSearched()));
    }));
    on<RefreshWeather>(((event, emit) async {
      emit(state.copyWith(weatherStatus: WeatherIsLoading()));
    try {
      WeatherResponce weather =
          await weatherRepo.fetchWeatherData(state.lat, state.lon);
      emit(state.copyWith(
        weather: weather,
        cityName: state.cityName,
        lat: state.lat,
        lon: state.lon,
        weatherStatus: WeatherLoaded(),
      ));
    } catch (_) {
      emit(state.copyWith(weatherStatus: WeatherLoadedFail()));
    }
    }));
  }

}
