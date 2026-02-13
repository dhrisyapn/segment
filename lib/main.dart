import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:segment/core/services/network_service.dart';
import 'package:segment/features/home/presentation/pages/home.dart';
import 'package:segment/features/no_internet.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<InternetStatus>? _subscription;
  bool _isNoInternetPageOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _subscription = NetworkService().onStatusChange.listen((status) {
        if (status == InternetStatus.disconnected && !_isNoInternetPageOpen) {
          _isNoInternetPageOpen = true;
          navigatorKey.currentState
              ?.push(
                MaterialPageRoute(
                  builder: (context) => NoInternet(
                    onRetry: () async {
                      final hasInternet =
                          await NetworkService().hasInternetConnection;
                      if (hasInternet && navigatorKey.currentState!.canPop()) {
                        navigatorKey.currentState!.pop();
                        _isNoInternetPageOpen = false;
                      }
                    },
                  ),
                ),
              )
              .then((_) {
                _isNoInternetPageOpen = false;
              });
        }
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: Home(),
    );
  }
}
