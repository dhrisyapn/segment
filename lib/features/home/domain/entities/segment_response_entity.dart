class SegmentResponseEntity {
  final int? id;
  final String? name;
  final String? description;
  final String? tumbnail;
  final int? clientId;
  final int? published;
  final String? parentId;
  final int? order;
  final List<SubSegmentResponseEntity>? subSegments;
  SegmentResponseEntity({
    this.id,
    this.name,
    this.description,
    this.tumbnail,
    this.clientId,
    this.published,
    this.parentId,
    this.order,
    this.subSegments,
  });
}

class SubSegmentResponseEntity {
  final int? id;
  final String? name;
  final String? description;
  final String? tumbnail;
  final int? clientId;
  final int? published;
  final String? parentId;
  final int? order;

  SubSegmentResponseEntity({
    this.id,
    this.name,
    this.description,
    this.tumbnail,
    this.clientId,
    this.published,
    this.parentId,
    this.order,
  });
}
