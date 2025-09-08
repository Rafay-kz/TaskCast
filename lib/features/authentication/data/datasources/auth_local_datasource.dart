import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> login(String username, String password);
  Future<bool> isLoggedIn();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel?> login(String username, String password) async {
    if (username == AppConstants.dummyUsername &&
        password == AppConstants.dummyPassword) {
      await sharedPreferences.setBool(AppConstants.userLoggedInKey, true);
      return UserModel(username: username);
    }
    return null;
  }

  @override
  Future<bool> isLoggedIn() async {
    return sharedPreferences.getBool(AppConstants.userLoggedInKey) ?? false;
  }
}