import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_cast_app/features/weather/presentation/widget/weather_card.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchWeather());
  }

  Future<void> _refreshWeather() async {
    context.read<WeatherBloc>().add(FetchWeather());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshWeather,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              Widget content;
              if (state is WeatherInitial) {
                return const Center(child: Text("Current Weather Fetching..."));
              } else if (state is WeatherLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WeatherLoaded) {
                final weather = state.weather;
                content= WeatherCard(cityName: weather.cityName, temperature: weather.temperature, description: weather.description, condition: weather.icon);
              } else if (state is WeatherError) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox.shrink();
              }
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: content,
              );
            },
          ),
        ),
      ),
    );
  }
}
