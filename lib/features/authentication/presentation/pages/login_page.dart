import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:task_cast_app/common/widgets/custom_primary_button.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, AppRouter.dashboardRoute);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
           color: AppTheme.secondaryColor
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.largePadding),
                child: FadeInUp(
                  duration: AppConstants.slowAnimation,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.largePadding),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FadeInDown(
                              duration: AppConstants.mediumAnimation,
                              child: Icon(
                                Icons.lock_outline,
                                size: 80,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: AppConstants.largePadding),

                            FadeInLeft(
                              duration: AppConstants.mediumAnimation,
                              delay: const Duration(milliseconds: 200),
                              child: Text(
                                AppStrings.login,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppConstants.largePadding),

                            FadeInRight(
                              duration: AppConstants.mediumAnimation,
                              delay: const Duration(milliseconds: 400),
                              child: TextFormField(
                                controller: _usernameController,
                                decoration:  InputDecoration(
                                  labelText: AppStrings.username,
                                  prefixIcon: const Icon(Icons.person_outline),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:  const BorderSide(width: 1, color: AppTheme.secondaryColor),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(width: 1, color: AppTheme.secondaryColor),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(width: 1, color: AppTheme.warningColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(width: 1, color:AppTheme.secondaryColor),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(width: 1, color: AppTheme.secondaryColor),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter username';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: AppConstants.defaultPadding),

                            FadeInLeft(
                              duration: AppConstants.mediumAnimation,
                              delay: const Duration(milliseconds: 600),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  labelText: AppStrings.password,
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:  const BorderSide(width: 1, color: AppTheme.secondaryColor),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(width: 1, color: AppTheme.secondaryColor),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(width: 1, color: AppTheme.warningColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(width: 1, color:AppTheme.secondaryColor),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(width: 1, color: AppTheme.secondaryColor),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: AppConstants.largePadding),

                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return FadeInUp(
                                  duration: AppConstants.mediumAnimation,
                                  delay: const Duration(milliseconds: 800),
                                  child: state is AuthLoading?const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ):SizedBox(
                                    width: double.infinity,
                                    child: CustomPrimaryButton(
                                      onButtonPressed: (){
                                        state is AuthLoading ? null : _login();
                                      },
                                      title: AppStrings.login,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: AppConstants.defaultPadding),

                            FadeInUp(
                              duration: AppConstants.mediumAnimation,
                              delay: const Duration(milliseconds: 1000),
                              child: Container(
                                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceVariant,
                                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Demo Credentials:',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text('Username: ${AppConstants.dummyUsername}'),
                                    const Text('Password: ${AppConstants.dummyPassword}'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}