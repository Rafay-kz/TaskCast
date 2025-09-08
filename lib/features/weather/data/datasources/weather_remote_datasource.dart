import 'package:task_cast_app/core/constants/app_constants.dart';
import 'package:task_cast_app/core/services/network/network_response.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/network/api.dart';
import '../../domain/entities/weather.dart';
import 'package:either_dart/either.dart';

class WeatherRemoteDataSource {
  final Api api;

  WeatherRemoteDataSource(this.api);

  Future<Either<Failure, Weather>> fetchWeather({
    required double lat,
    required double lon,
  }) async {
    final url = "${AppConstants.weatherBaseUrl}lat=$lat&lon=$lon&units=metric&appid=${AppConstants.weatherApiKey}";

    final result = await api.call(RestMethod.get, url);

    return result.fold(
          (failure) => Left(failure),
          (NetworkResponse response) {
        final weather = Weather.fromJson(response.responseData);
        return Right(weather);
      },
    );
  }
}
