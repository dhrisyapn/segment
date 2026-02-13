import 'package:segment/features/home/domain/entities/segment_response_entity.dart';

abstract class UserAuthRepository {
  // This defines WHAT needs to happen, but not HOW.
  Future<List<SegmentResponseEntity>> getSegments();
}
