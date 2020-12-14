import 'package:jaguar_orm/jaguar_orm.dart';

class InitiativeQualify {
  @PrimaryKey(auto: false)
  int id;
  @Column(isNullable: true)
  int initiativeId;
  @Column(isNullable: true)
  int qualifiedProduct;
  @Column(isNullable: true)
  String productstatus;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;

  InitiativeQualify({
    this.id,
    this.initiativeId,
    this.qualifiedProduct,
    this.productstatus,
    this.createdAt,
    this.updatedAt,
  });

  factory InitiativeQualify.fromMap(Map<String, dynamic> json) =>
      InitiativeQualify(
        id: json["id"],
        initiativeId: json["initiative_id"],
        qualifiedProduct: json["qualified_product"],
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
        "qualified_product": qualifiedProduct,
        "productstatus": productstatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
