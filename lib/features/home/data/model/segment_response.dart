import 'package:segment/features/home/domain/entities/segment_response_entity.dart';

class SegmentResponseModel extends SegmentResponseEntity {
  SegmentResponseModel({
    super.id,
    super.name,
    super.description,
    super.tumbnail,
    super.clientId,
    super.published,
    super.parentId,
    super.order,
    super.subSegments,
  });

  factory SegmentResponseModel.fromJson(Map<String, dynamic> json) {
    return SegmentResponseModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['desc'] as String?,
      tumbnail: json['thumbnail'] as String?,
      clientId: json['client_id'] as int?,
      published: json['is_published'] as int?,
      parentId: json['parent_id']?.toString(),
      order: json['order'] as int?,
      subSegments: json['sub_segments'] == null
          ? []
          : (json['sub_segments'] as List)
                .map(
                  (e) => SubSegmentResponseModel.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
    );
  }
}

class SubSegmentResponseModel extends SubSegmentResponseEntity {
  SubSegmentResponseModel({
    super.id,
    super.name,
    super.description,
    super.tumbnail,
    super.clientId,
    super.published,
    super.parentId,
    super.order,
  });

  factory SubSegmentResponseModel.fromJson(Map<String, dynamic> json) {
    return SubSegmentResponseModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['desc'] as String?,
      tumbnail: json['thumbnail'] as String?,
      clientId: json['client_id'] as int?,
      published: json['is_published'] as int?,
      parentId: json['parent_id']?.toString(),
      order: json['order'] as int?,
    );
  }
}
