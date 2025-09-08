import 'package:either_dart/either.dart';
import '../../../../core/error/failure.dart';
import '../entities/weather.dart';
import '../repositroies/weather_repository.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<Either<Failure, Weather>> call({
    required double lat,
    required double lon,
  }) {
    return repository.fetchWeather(lat: lat, lon: lon);
  }
}
