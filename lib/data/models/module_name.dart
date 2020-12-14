import 'package:jaguar_orm/jaguar_orm.dart';

class ModuleName {
  @PrimaryKey(auto: false)
  int id;
  @Column(isNullable: true)
  int moduleId;
  @Column(isNullable: true)
  String moduleName;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;
  @Column(isNullable: true)
  String modulecat;
  @Column(isNullable: true)
  String key;
  @Column(isNullable: true)
  String applabel;
  @Column(isNullable: true)
  String status;

  ModuleName({
    this.id,
    this.moduleId,
    this.moduleName,
    this.createdAt,
    this.updatedAt,
    this.modulecat,
    this.key,
    this.applabel,
    this.status,
  });

  factory ModuleName.fromMap(Map<String, dynamic> json) => ModuleName(
        id: json["id"],
        moduleId: json["module_id"],
        moduleName: json["module_name"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        modulecat: json["modulecat"],
        key: json["key"],
        applabel: json["applabel"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "module_id": moduleId,
        "module_name": moduleName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "modulecat": modulecat,
        "key": key,
        "applabel": applabel,
        "status": status,
      };
}
