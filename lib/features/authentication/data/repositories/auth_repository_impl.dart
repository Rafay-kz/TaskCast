import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<User?> login(String username, String password) async {
    return await localDataSource.login(username, password);
  }



  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.isLoggedIn();
  }
}