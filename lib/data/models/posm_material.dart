import 'package:jaguar_orm/jaguar_orm.dart';

class PosmMaterial {
  @PrimaryKey()
  int id;
  @Column(isNullable: true)
  String itemname;
  @Column(isNullable: true)
  String itemtype;
  @Column(isNullable: true)
  String status;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;

  PosmMaterial({
    this.id,
    this.itemname,
    this.itemtype,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PosmMaterial.fromMap(Map<String, dynamic> json) => PosmMaterial(
        id: json["id"],
        itemname: json["itemname"],
        itemtype: json["itemtype"],
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
        "itemname": itemname,
        "itemtype": itemtype,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
