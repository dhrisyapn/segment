import 'dart:developer';

import 'package:segment/core/services/api_services.dart';
import 'package:segment/features/home/data/data_sources/user_auth_datasource_interface.dart';
import 'package:segment/features/home/data/model/segment_response.dart';
import 'package:segment/features/home/domain/entities/segment_response_entity.dart';

class UserAuthDataSourceImpl implements UserAuthDataSource {
  @override
  Future<List<SegmentResponseEntity>> getSegment() async {
    final data = await ApiServices.get(
      '/v2/segments',
      queryParameters: {'client_id': '2'},
    );
    log(data.toString());
    if (data is List) {
      return data
          .map((e) => SegmentResponseModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (data is Map && data.containsKey('error')) {
      // Handle server-side error response
      throw (data['error'] ?? 'Unknown API error');
    }
    return [];
  }
}
