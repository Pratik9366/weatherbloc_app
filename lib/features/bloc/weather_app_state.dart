part of 'weather_app_bloc.dart';

@immutable
abstract class WeatherAppState {}

class WeatherAppInitial extends WeatherAppState {}

class WeatherModelFetchingSuccessfulState extends WeatherAppState {
  final List<WeatherModel> weathers;

  WeatherModelFetchingSuccessfulState({required this.weathers});
}
