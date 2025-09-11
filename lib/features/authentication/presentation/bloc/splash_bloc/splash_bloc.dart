import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_cast_app/features/authentication/domain/repositories/auth_repository.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository authRepository;
  SplashBloc({
    required this.authRepository,
  }) : super(SplashInitialState()) {
    on<AuthRquestedEvent>(_onCheckLoggedIn);
  }

  Future<void> _onCheckLoggedIn(
      AuthRquestedEvent event,
      Emitter<SplashState> emit,
      ) async {
    final isLoggedIn = await authRepository.isLoggedIn();
    if(isLoggedIn){
      emit(SplashAuthenticatedState());
    }else{
      emit(SplashUnAuthenticatedState());
    }
  }


}