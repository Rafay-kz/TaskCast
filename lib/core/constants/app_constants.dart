class AppConstants {
  // Authentication
  static const String dummyUsername = 'test';
  static const String dummyPassword = '1234';

  // Storage
  static const String todoBoxName = 'todos';
  static const String userLoggedInKey = 'user_logged_in';

  // API
  static const String weatherApiKey = 'c0a25c2740a1bfcc0e98caedef12f753';
  static const String weatherBaseUrl = 'https://api.openweathermap.org/data/2.5/weather?';

  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration slowAnimation = Duration(milliseconds: 600);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 4.0;
}

class AppStrings {
  // Authentication
  static const String login = 'Login';
  static const String username = 'Username';
  static const String password = 'Password';
  static const String loginError = 'Invalid username or password';
  static const String loginSuccess = 'Login Successful';
  static const String logout = 'Logout';

  // Todo
  static const String todos = 'To-Do List';
  static const String addTodo = 'Add Todo';
  static const String todoTitle = 'Title';
  static const String todoDescription = 'Description';
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String noTodos = 'No todos yet. Add one!';
  static const String todoAdded = 'Todo added successfully';
  static const String todoUpdated = 'Todo updated successfully';
  static const String todoDeleted = 'Todo deleted successfully';

  // Weather
  static const String weather = 'Weather';
  static const String refreshWeather = 'Pull to refresh';
  static const String locationError = 'Could not get your location';
  static const String weatherError = 'Could not fetch weather data';
  static const String permissionDenied = 'Location permission denied';

  // General
  static const String dashboard = 'Dashboard';
  static const String error = 'Error';
  static const String retry = 'Retry';
  static const String noInternet = 'Please connect internet';
  static const String loading = 'Loading...';
}