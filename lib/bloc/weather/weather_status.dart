abstract class WeatherStatus {
  const WeatherStatus();
}

class WeatherIsNotSearched extends WeatherStatus {}

class WeatherInitial extends WeatherStatus {
  const WeatherInitial();
}

class WeatherIsLoading extends WeatherStatus {}

class WeatherLoaded extends WeatherStatus {}

class WeatherLoadedFail extends WeatherStatus {}
