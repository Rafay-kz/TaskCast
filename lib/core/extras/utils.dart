import 'package:connectivity_plus/connectivity_plus.dart';

class Utils{

  static Future<bool> isNetworkConnected() async {
    final connectivity = await Connectivity().checkConnectivity();
    bool connection = connectivity == ConnectivityResult.wifi ||
        connectivity == ConnectivityResult.mobile;
    return connection;
  }

}