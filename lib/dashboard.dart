import 'package:flutter/material.dart';
import 'package:task_cast_app/core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/theme_cubit.dart';
import 'features/todo/presentation/pages/todo_page.dart';
import 'features/weather/presentation/pages/weather_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          backgroundColor: AppTheme.secondaryColor,
          elevation: 0,
          centerTitle: true,
          actions: [
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return IconButton(
                  icon: Icon(
                    themeMode == ThemeMode.dark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: AppTheme.lightBackground,
                  ),
                  onPressed: () {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                );
              },
            ),
          ],

        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: AppTheme.secondaryColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: AppTheme.secondaryColor,
                    tabs: [
                      _buildTab(Icons.list, "To-Do"),
                      _buildTab(Icons.cloud, "Weather"),
                    ],
                    dividerColor: Colors.transparent,
                  ),
                ),
               const Expanded(child:
               TabBarView(
                 children: [
                   TodoPage(),
                   WeatherPage(),
                 ],
               ),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Tab _buildTab(IconData icon, String text) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
