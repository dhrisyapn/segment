import '../entities/segment_response_entity.dart';
import '../repositories/user_auth_repository_interface.dart';

class GetSegmentsUseCase {
  final UserAuthRepository repository;

  GetSegmentsUseCase({required this.repository});

  Future<List<SegmentResponseEntity>> call() {
    return repository.getSegments();
  }
}
