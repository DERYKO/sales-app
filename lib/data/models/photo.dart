import 'package:jaguar_orm/jaguar_orm.dart';

class Photo {
  @PrimaryKey(auto: true)
  int id;
  @Column(
    isNullable: true,
  )
  String source;
  @Column(
    isNullable: true,
  )
  int sourceId;
  @Column(
    isNullable: true,
  )
  String photoName;
  @Column(
    isNullable: true,
  )
  DateTime createdAt;
  @Column(
    isNullable: true,
  )
  DateTime updatedAt;

  Photo({
    this.id,
    this.source,
    this.sourceId,
    this.photoName,
    this.createdAt,
    this.updatedAt,
  });

  factory Photo.fromMap(Map<String, dynamic> json) => Photo(
        id: json["id"],
        source: json["source"],
        sourceId: json["source_id"],
        photoName: json["photo_name"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "source": source,
        "source_id": sourceId,
        "photo_name": photoName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
