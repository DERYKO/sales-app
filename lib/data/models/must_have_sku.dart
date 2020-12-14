import 'package:jaguar_orm/jaguar_orm.dart';

class MustHaveSku {
  @PrimaryKey(auto: false)
  int id;
  @Column(isNullable: true)
  int customercategory;
  @Column(isNullable: true)
  int productId;
  @Column(isNullable: true)
  String status;
  @Column(isNullable: true)
  int addedby;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;

  MustHaveSku({
    this.id,
    this.customercategory,
    this.productId,
    this.status,
    this.addedby,
    this.createdAt,
    this.updatedAt,
  });

  factory MustHaveSku.fromMap(Map<String, dynamic> json) => MustHaveSku(
        id: json["id"],
        customercategory: json["customercategory"],
        productId: json["product_id"],
        status: json["status"],
        addedby: json["addedby"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "customercategory": customercategory,
        "product_id": productId,
        "status": status,
        "addedby": addedby,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
