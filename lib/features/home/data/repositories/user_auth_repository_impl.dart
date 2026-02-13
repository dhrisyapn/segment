import 'package:segment/features/home/data/data_sources/user_auth_datasource_interface.dart';
import 'package:segment/features/home/domain/entities/segment_response_entity.dart';
import 'package:segment/features/home/domain/repositories/user_auth_repository_interface.dart';

class UserAuthRepositoryImpl implements UserAuthRepository {
  // The Repository relies on the Data Source
  final UserAuthDataSource dataSource;

  UserAuthRepositoryImpl({required this.dataSource});

  @override
  Future<List<SegmentResponseEntity>> getSegments() async {
    // It calls the Data Source to get the actual data
    return await dataSource.getSegment();
  }
}
