import 'package:jaguar_orm/jaguar_orm.dart';

class PackagingOption {
  @PrimaryKey(auto: false)
  int id;
  @Column(isNullable: true)
  String packageName;
  @Column(isNullable: true)
  String packageKey;
  @Column(isNullable: true)
  String status;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;

  PackagingOption({
    this.id,
    this.packageName,
    this.packageKey,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PackagingOption.fromMap(Map<String, dynamic> json) => PackagingOption(
        id: json["id"],
        packageName: json["package_name"],
        packageKey: json["package_key"],
        status: json["status"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "package_name": packageName,
        "package_key": packageKey,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
