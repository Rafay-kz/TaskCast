import 'package:either_dart/either.dart';
import 'package:task_cast_app/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:task_cast_app/features/weather/domain/repositroies/weather_repository.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/weather.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Weather>> fetchWeather({
    required double lat,
    required double lon,
  }) async {
    return await remoteDataSource.fetchWeather(lat: lat, lon: lon);
  }
}
