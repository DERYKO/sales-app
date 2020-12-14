import 'package:jaguar_orm/jaguar_orm.dart';

class ProductAvailabilityDetail {
  @Column(isNullable: true)
  int availabilityId;
  @Column(isNullable: true)
  int productId;
  @Column(isNullable: true)
  String productName;
  @Column(isNullable: true)
  String availabilityStatus;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;
  @Column(isNullable: true)
  String reason;
  @Column(isNullable: true)
  String notes;
  @Column(isNullable: true)
  String quantity;

  ProductAvailabilityDetail({
    this.availabilityId,
    this.productId,
    this.productName,
    this.availabilityStatus,
    this.createdAt,
    this.updatedAt,
    this.reason,
    this.quantity,
    this.notes,
  });

  factory ProductAvailabilityDetail.fromMap(Map<String, dynamic> json) =>
      ProductAvailabilityDetail(
        availabilityId: json["availability_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        availabilityStatus: json["availability_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        reason: json["reason"],
        quantity: json["quantity"],
        notes: json["notes"],
      );

  Map<String, dynamic> toMap() => {
        "availability_id": availabilityId,
        "product_id": productId,
        "product_name": productName,
        "availability_status": availabilityStatus,
        "created_at": updatedAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "reason": reason,
        "quantity": quantity,
        "notes": notes,
      };
}
