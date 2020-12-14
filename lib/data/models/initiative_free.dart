import 'package:jaguar_orm/jaguar_orm.dart';

class InitiativeFree {
  @PrimaryKey(auto: false)
  int id;
  @Column(isNullable: true)
  int initiativeId;
  @Column(isNullable: true)
  int freeProduct;
  @Column(isNullable: true)
  String productstatus;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;

  InitiativeFree({
    this.id,
    this.initiativeId,
    this.freeProduct,
    this.productstatus,
    this.createdAt,
    this.updatedAt,
  });

  factory InitiativeFree.fromMap(Map<String, dynamic> json) => InitiativeFree(
        id: json["id"],
        initiativeId: json["initiative_id"],
        freeProduct: json["free_product"],
        productstatus: json["productstatus"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "initiative_id": initiativeId,
        "free_product": freeProduct,
        "productstatus": productstatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
