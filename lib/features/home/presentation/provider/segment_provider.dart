import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:segment/features/home/data/data_sources/user_auth_datasource_impl.dart';
import 'package:segment/features/home/data/repositories/user_auth_repository_impl.dart';
import 'package:segment/features/home/domain/entities/segment_response_entity.dart';
import 'package:segment/features/home/domain/usecases/get_segments_usecase.dart';

// Data Source Provider
final userAuthDataSourceProvider = Provider((ref) {
  return UserAuthDataSourceImpl();
});

// Repository Provider
final userAuthRepositoryProvider = Provider((ref) {
  final dataSource = ref.watch(
    userAuthDataSourceProvider,
  ); // The Repository depends on the Data Source
  return UserAuthRepositoryImpl(dataSource: dataSource);
});

// Use Case Provider
final getSegmentsUseCaseProvider = Provider((ref) {
  final repository = ref.watch(userAuthRepositoryProvider);
  return GetSegmentsUseCase(repository: repository);
});

// Segment Data Provider
final segmentProvider = FutureProvider<List<SegmentResponseEntity>>((
  ref,
) async {
  final getSegmentsUseCase = ref.watch(getSegmentsUseCaseProvider);
  return await getSegmentsUseCase();
});
