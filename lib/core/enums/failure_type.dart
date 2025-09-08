
import 'package:task_cast_app/core/enums/StatusThemeType.dart';

enum FailureType {
  general(StatusThemeType.red),
  noInternetError(StatusThemeType.red),
  unAuthenticatedError(StatusThemeType.red),
  resourceNotFound(StatusThemeType.red),
  serverError(StatusThemeType.red),
  serviceUnavailable(StatusThemeType.red);

  const FailureType(this.themeType);

  final StatusThemeType themeType;
}
