import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_cast_app/features/weather/domain/usecases/weather_usecase.dart';

import '../../features/authentication/data/datasources/auth_local_datasource.dart';
import '../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../features/authentication/domain/repositories/auth_repository.dart';
import '../../features/authentication/domain/usecases/login_usecase.dart';
import '../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../../features/todo/data/datassources/todo_local_datasource.dart';
import '../../features/todo/data/repositories/todo_repository_impl.dart';
import '../../features/todo/domain/repositories/todo_repository.dart';
import '../../features/todo/domain/usecases/todo_usecase.dart';
import '../../features/todo/presentation/bloc/todo_bloc.dart';
import '../../features/weather/data/datasources/weather_remote_datasource.dart';
import '../../features/weather/data/repositories/weather_repository_impl.dart';
import '../../features/weather/domain/repositroies/weather_repository.dart';
import '../../features/weather/presentation/bloc/weather_bloc.dart';
import '../services/network/api.dart';


final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl(),
    checkLoginStatusUseCase: sl(),
  ));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => CheckLoginStatusUseCase(sl()));
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerFactory(() => TodoBloc(
    addTodoUseCase: sl(),
    getTodosUseCase: sl(),
    toggleTodoUseCase: sl(),
    deleteTodoUseCase: sl(),
  ));
  sl.registerLazySingleton(() => AddTodoUseCase(sl()));
  sl.registerLazySingleton(() => GetTodosUseCase(sl()));
  sl.registerLazySingleton(() => ToggleTodoUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTodoUseCase(sl()));
  sl.registerLazySingleton<TodoRepository>(
        () => TodoRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<TodoLocalDataSource>(
        () => TodoLocalDataSourceImpl(),
  );
  sl.registerFactory(() => WeatherBloc(getWeatherUseCase: sl()));
  sl.registerLazySingleton(() => GetWeatherUseCase(sl()));
  sl.registerLazySingleton<WeatherRepository>(
        () => WeatherRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<Api>(() => Api());
  sl.registerLazySingleton<WeatherRemoteDataSource>(
        () => WeatherRemoteDataSource(sl()),
  );

}