import 'package:either_dart/either.dart';
import '../../../../core/error/failure.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> fetchWeather({
    required double lat,
    required double lon,
  });
}
