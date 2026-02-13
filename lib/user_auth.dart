import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:segment/core/services/api_services.dart';
import 'package:segment/features/home/data/model/segment_response.dart';
import 'package:segment/features/home/domain/entities/segment_response_entity.dart';

class UserAuth {
  Future<List<SegmentResponseEntity>> getSegment(BuildContext context) async {
    try {
      final data = await ApiServices.get(
        '/v2/segments',
        queryParameters: {'client_id': '2'},
      );
      log(data.toString());
      if (data is List) {
        return data
            .map(
              (e) => SegmentResponseModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      } else if (data is Map && data.containsKey('error')) {
        // Handle server-side error response
        throw (data['error'] ?? 'Unknown API error');
      }
    } catch (e) {
      // Log the error or handle it as needed
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
    }
    return [];
  }
}
