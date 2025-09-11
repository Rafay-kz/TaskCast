import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_cast_app/features/authentication/presentation/bloc/splash_bloc/splash_bloc.dart';

import '../../../../app_router.dart';
import '../../../../core/theme/app_theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticatedState) {
            Navigator.pushReplacementNamed(context, AppRouter.dashboardRoute);
          } else if (state is SplashUnAuthenticatedState) {
            Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
          }
        },
        child: Container(
          decoration: const BoxDecoration(
              color: AppTheme.secondaryColor
          ),
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}