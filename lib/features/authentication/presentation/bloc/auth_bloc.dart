import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final CheckLoginStatusUseCase checkLoginStatusUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.checkLoginStatusUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<CheckLoginStatus>(_onCheckLoginStatus);
  }

  Future<void> _onLoginRequested(
      LoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      final user = await loginUseCase(event.username, event.password);

      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(const AuthError(message: 'Invalid username or password'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }


  Future<void> _onCheckLoginStatus(
      CheckLoginStatus event,
      Emitter<AuthState> emit,
      ) async {
    final isLoggedIn = await checkLoginStatusUseCase();

    if (isLoggedIn) {
      emit(const AuthAuthenticated(user: User(username: 'test')));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}