import 'package:dio/dio.dart';

import '../../../../common/models/status.dart';
import '../../../constants/app_constants.dart';
import '../../../enums/failure_type.dart';

class LoggingInterceptor extends Interceptor {
  final Dio dio;

  LoggingInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    //failed HTTP case
    final response = err.response;
    String? msg;
    var failureType = FailureType.general;

    if (err.error == "XMLHttpRequest error.") {
      failureType = FailureType.noInternetError;
      msg ??= AppStrings.noInternet;
    }

    try {
      if (response != null && response.data != null) {
        if (response.data["error_description"] != null) {
          msg = response.data["error_description"] ?? "Something went wrong";
        }

        if (response.data["status"] != null) {
          Status status = Status.fromJson(response.data["status"]);
          if (status.code != 200 && status.message != null) {
            msg = status.message ?? "Something went wrong";
          }
        }
      }
    } catch (e) {}

    switch (err.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        msg ??= 'The connection has timed out, please try again';
        break;
      case DioErrorType.badResponse:
        if (err.response != null) {
          switch (err.response?.statusCode) {
            case 400:
              // bad request
              msg ??= "There was something wrong with your request, and the server couldn't understand it";
              break;
            case 401:
              failureType = FailureType.unAuthenticatedError;
              msg ??= "You need to log in to access the resource you requested";
              break;
            case 403:
              // forbidden
              msg ??= "You don't have permission to access the resource you requested";
              break;
            case 404:
              // not found
              failureType = FailureType.resourceNotFound;
              msg ??= "The server couldn't find the resource you requested";
              break;
            case 500:
              failureType = FailureType.serverError;
              msg ??= "Something went wrong on the server, and it couldn't fulfill your request";
              break;
            case 503:
              failureType = FailureType.serviceUnavailable;
              msg ??= "The server is currently unable to handle your request due to maintenance or overload";
              break;
            default:
              break;
          }
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.unknown:
        failureType = FailureType.noInternetError;
        msg ??= AppStrings.noInternet;
      case DioErrorType.badCertificate:
        // TODO: Handle this case.
      case DioErrorType.connectionError:
        // TODO: Handle this case.
    }


    throw NetworkException(err.requestOptions, failureType,
        msg ?? "Something went wrong", err.type);
  }
}

class NetworkException extends DioError {
  String status;
  FailureType failureType;

  NetworkException(
      RequestOptions r, this.failureType, this.status, DioErrorType type)
      : super(requestOptions: r, type: type);

  @override
  String toString() {
    return status;
  }
}
