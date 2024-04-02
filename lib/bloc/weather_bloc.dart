import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      
      emit(WeatherLoading());
      try {
        WeatherFactory weatherFactory = WeatherFactory(
            '${dotenv.env['WEATHER_API-KEY']}',
            language: Language.ENGLISH);

        Weather weather = await weatherFactory.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
        emit(WeatherSuccess(weather: weather));
      } catch (e) {
        emit(WeatherFailure());
      }
    });
  }
  @override
  void onChange(Change<WeatherState> change) {
    super.onChange(change);
    print('on change => $change');
  }

  @override
  void onTransition(Transition<WeatherEvent, WeatherState> transition) {
    super.onTransition(transition);
    print("Transition => $transition");
  }
}
