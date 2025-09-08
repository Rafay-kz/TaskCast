import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherCard extends StatelessWidget {
  final String cityName;
  final double temperature;
  final String description;
  final String condition;

  const WeatherCard({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _getGradient(condition),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 150,
            child: Lottie.asset(
              _getAnimation(condition),
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            cityName,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            "${temperature.toStringAsFixed(1)}°C",
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            description,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  String _getAnimation(String condition) {
    switch (condition.toLowerCase()) {
      case 'clouds':
        return 'assets/lottie/cloudy.json';
      case 'rain':
        return 'assets/lottie/rainy.json';
      case 'clear':
        return 'assets/lottie/sunny.json';
      case 'snow':
        return 'assets/lottie/snow.json';
      default:
        return 'assets/lottie/weather.json';
    }
  }

  // Gradient color based on weather
  List<Color> _getGradient(String condition) {
    switch (condition.toLowerCase()) {
      case 'clouds':
        return [Colors.blueGrey, Colors.grey];
      case 'rain':
        return [Colors.indigo, Colors.blueGrey];
      case 'clear':
        return [Colors.orange, Colors.pinkAccent];
      case 'snow':
        return [Colors.lightBlueAccent, Colors.white];
      default:
        return [Colors.blue, Colors.lightBlueAccent];
    }
  }
}
