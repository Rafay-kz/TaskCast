import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:task_cast_app/core/constants/app_constants.dart';
import 'package:task_cast_app/core/enums/message_type.dart';
import '../../../common/models/status.dart';
import '../../enums/failure_type.dart';
import '../../error/failure.dart';
import '../../extras/utils.dart';
import 'interceptors/log_interceptor.dart';
import 'network_response.dart';

class Api {
  final dio = createDio();
  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: AppConstants.weatherBaseUrl,
      receiveTimeout: const Duration(minutes: 4),
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(minutes: 4),
    ));


    return dio;
  }


  // send get request to server
  Future<Either<Failure, NetworkResponse>> call(RestMethod method, String url,
      [String? body]) async {
    if (!(await Utils.isNetworkConnected())) {
      return Left(Failure(
          message: AppStrings.noInternet,
          messageType: MessageType.error,
          failureType: FailureType.noInternetError));
    }

    late Response response;

    switch (method) {
      case RestMethod.get:
        try {
          response = await dio.get(url);
        } on NetworkException catch (e) {
          return _handleNetworkError(e);
        }
        break;

      case RestMethod.post:
        try {
          response = await dio.post(url, data: body);
        } on NetworkException catch (e) {
          return _handleNetworkError(e);
        }
        break;

      case RestMethod.put:
        try {
          response = await dio.put(url, data: body);
        } on NetworkException catch (e) {
          return _handleNetworkError(e);
        }
        break;

      case RestMethod.delete:
        try {
          response = await dio.delete(url, data: body);
        } on NetworkException catch (e) {
          return _handleNetworkError(e);
        }
        break;
    }

    //failed HTTP case


    Status? status;
    if (response.data != null && response.data["status"] != null) {
      status = Status.fromJson(response.data["status"]);
      if (status.code != 200 && status.message != null) {
        return Left(
            Failure(message: status.message!, messageType: MessageType.error));
      }
    }

    if (response.statusCode != 200 &&
        (response.statusMessage != null || response.data["Message"] != null)) {
      String errorMessage = response.statusMessage ?? response.data["Message"];
      return Left(
          Failure(message: errorMessage, messageType: MessageType.error));
    }

    //handle success
    if (response.data!['data'] != null) {
      return Right(
          NetworkResponse.statusResponse(status, response.data!['data']));
    } else {
      return Right(NetworkResponse.statusResponse(status, response.data!));
    }
  }

  Left<Failure, NetworkResponse> _handleNetworkError(NetworkException e) {
    return Left(Failure(
        message: e.toString(),
        failureType: e.failureType,
        messageType: MessageType.error));
  }

}

enum RestMethod { put, get, post, delete }
