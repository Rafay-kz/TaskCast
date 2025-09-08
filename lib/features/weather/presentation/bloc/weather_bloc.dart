import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_cast_app/features/weather/presentation/bloc/weather_event.dart';
import 'package:task_cast_app/features/weather/presentation/bloc/weather_state.dart';
import 'package:location/location.dart';
import '../../domain/usecases/weather_usecase.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;

  WeatherBloc({required this.getWeatherUseCase}) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
      FetchWeather event,
      Emitter<WeatherState> emit,
      ) async {
    emit(WeatherLoading());

    try {
      final locationData = await _getCurrentLocation();
      final result = await getWeatherUseCase(
        lat: locationData.latitude!,
        lon: locationData.longitude!,
      );

      result.fold(
            (failure) {
          emit(WeatherError(message: failure.message));
        },
            (weather) {
          emit(WeatherLoaded(weather: weather));
        },
      );
    } catch (e) {
      emit(WeatherError(message: e.toString()));
    }
  }






  Future<LocationData> _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }
    }

    // Check permissions
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('Location permission denied.');
      }
    }

    // Get location
    return await location.getLocation();
  }


}
