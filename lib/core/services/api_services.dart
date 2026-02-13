import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:segment/core/services/network_service.dart';
import 'package:segment/features/no_internet.dart';
import 'package:segment/main.dart';

class ApiServices {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.elearning.alpha.logidots.com/api',
      headers: {'Accept': 'application/json', 'X-App-Type': 'learner'},
      validateStatus: (status) {
        return status != null && (status == 200 || status == 201);
      },
    ),
  );

  static Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _handleRequest(
      () => _dio.get(endpoint, queryParameters: queryParameters),
    );
  }

  static Future<dynamic> post(String endpoint, {dynamic body}) async {
    return _handleRequest(() => _dio.post(endpoint, data: body));
  }

  static Future<dynamic> put(String endpoint, {dynamic body}) async {
    return _handleRequest(() => _dio.put(endpoint, data: body));
  }

  static Future<dynamic> patch(String endpoint, {dynamic body}) async {
    return _handleRequest(() => _dio.patch(endpoint, data: body));
  }

  static Future<dynamic> delete(String endpoint, {dynamic body}) async {
    return _handleRequest(() => _dio.delete(endpoint, data: body));
  }

  static Future<dynamic> _handleRequest(
    Future<Response> Function() request,
  ) async {
    final hasInternet = await NetworkService().hasInternetConnection;
    if (!hasInternet) {
      final result = await navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => const NoInternet()),
      );

      if (result == true) {
        return _handleRequest(request);
      }
      return null;
    }

    try {
      final response = await request();
      log(response.data.toString());
      return response.data;
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? e.message ?? 'Unknown DioError');
      if (e.response != null) {
        return e.response?.data;
        //_showError(e.response?.data);
      } else {
        // _showSnackbar(e.message ?? 'Something went wrong');
      }
      return null;
    } catch (e) {
      log(e.toString());
      //_showSnackbar('An unexpected error occurred');
      return null;
    }
  }

  static void _showError(dynamic data) {
    if (data is Map<String, dynamic> &&
        (data.containsKey('error') || data.containsKey('message'))) {
      final message = data['error'] ?? data['message'];
      if (message is List) {
        if (message.isNotEmpty) {
          // _showSnackbar(message.first.toString());
        }
      } else {
        //  _showSnackbar(message.toString());
      }
    } else {
      //  _showSnackbar('An error occurred');
    }
  }

  // static void _showSnackbar(String message) {
  // scaffoldMessengerKey.currentState?.showSnackBar(
  //   SnackBar(
  //     content: Text(
  //       message,
  //       textAlign: TextAlign.center,
  //       style: GoogleFonts.onest(
  //         color: Colors.white,
  //         fontSize: 14.sp,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //     backgroundColor: Colors.red,
  //     duration: const Duration(seconds: 3),
  //     elevation: 1,
  //     margin: EdgeInsets.all(16.0),
  //     behavior: SnackBarBehavior.floating,
  //     dismissDirection: DismissDirection.horizontal,
  //   ),
  // );
}
//}

/*
Usage Examples:

// GET Request
final data = await ApiServices.get('/users', queryParameters: {'page': 1});

// POST Request with body
final response = await ApiServices.post('/login', body: {'email': 'test@test.com', 'password': '123'});

// POST Request without body
final response = await ApiServices.post('/logout');

// PUT Request with body
final response = await ApiServices.put('/users/1', body: {'name': 'New Name'});

// PUT Request without body
final response = await ApiServices.put('/users/1/activate');

// PATCH Request with body
final response = await ApiServices.patch('/users/1', body: {'active': true});

// DELETE Request
final response = await ApiServices.delete('/users/1');

// DELETE Request with body
final response = await ApiServices.delete('/users/delete-batch', body: {'ids': [1, 2, 3]});
*/
