import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() {
    return _instance;
  }

  NetworkService._internal();

  final InternetConnection _internetConnection = InternetConnection();

  Stream<InternetStatus> get onStatusChange =>
      _internetConnection.onStatusChange;

  Future<bool> get hasInternetConnection async {
    return await _internetConnection.hasInternetAccess;
  }
}
