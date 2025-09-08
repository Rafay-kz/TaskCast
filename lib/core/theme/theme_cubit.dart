import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme() async {
    final box = Hive.box('settings');
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      await box.put('theme', 'dark');
    } else {
      emit(ThemeMode.light);
      await box.put('theme', 'light');
    }
  }

  void loadTheme() {
    final box = Hive.box('settings');
    final theme = box.get('theme', defaultValue: 'system');
    if (theme == 'dark') {
      emit(ThemeMode.dark);
    } else if (theme == 'light') {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.system);
    }
  }
}
