import 'package:segment/features/home/domain/entities/segment_response_entity.dart';

abstract class UserAuthDataSource {
  Future<List<SegmentResponseEntity>> getSegment();
}
