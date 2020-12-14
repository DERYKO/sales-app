import 'package:jaguar_orm/jaguar_orm.dart';

class Csku {
  @PrimaryKey(auto: true)
  int id;
  @Column(
    isNullable: true,
  )
  String categoryName;
  @Column(
    isNullable: true,
  )
  String cskuName;
  @Column(
    isNullable: true,
  )
  String status;
  @Column(
    isNullable: true,
  )
  int addedBy;
  @Column(
    isNullable: true,
  )
  DateTime createdAt;
  @Column(
    isNullable: true,
  )
  DateTime updatedAt;

  Csku({
    this.id,
    this.categoryName,
    this.cskuName,
    this.status,
    this.addedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Csku.fromMap(Map<String, dynamic> json) => Csku(
        id: json["id"],
        categoryName: json["category_name"],
        cskuName: json["csku_name"],
        status: json["status"],
        addedBy: json["added_by"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_name": categoryName,
        "csku_name": cskuName,
        "status": status,
        "added_by": addedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
