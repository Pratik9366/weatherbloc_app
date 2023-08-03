import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/features/models/weather_model.dart';

part 'weather_app_event.dart';
part 'weather_app_state.dart';

class WeatherAppBloc extends Bloc<WeatherAppEvent, WeatherAppState> {
  WeatherAppBloc() : super(WeatherAppInitial()) {
    on<WeatherFatchIntialEvent>(weatherFatchIntialEvent);
  }

  FutureOr<void> weatherFatchIntialEvent(
      WeatherFatchIntialEvent event, Emitter<WeatherAppState> emit) async {
    var client = http.Client();

    List<WeatherModel> weathers = [];
    try {
      final response = await client.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=Kumarghat,tripura,uk&APPID=5c5a18d32f63f7008f34946709cc12c6"));

      List result = jsonDecode(response.body);
      for (var i = 0; i < result.length; i++) {
        WeatherModel weather =
            WeatherModel.fromJson(result[i] as Map<String, dynamic>);
        weathers.add(weather);
      }
      emit(WeatherModelFetchingSuccessfulState(weathers: weathers));
    } catch (e) {
      throw e.toString();
    }
  }
}
