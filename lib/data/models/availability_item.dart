import 'package:jaguar_orm/jaguar_orm.dart';

class AvailabilityItem {
  @Column(isNullable: true)
  int availabilityId;
  @Column(isNullable: true)
  int productId;
  @Column(isNullable: true)
  String productName;
  @Column(isNullable: true)
  String availabilityStatus;
  @Column(isNullable: true)
  String availabilityReason;

  AvailabilityItem({
    this.availabilityId,
    this.productId,
    this.productName,
    this.availabilityStatus,
    this.availabilityReason,
  });

  factory AvailabilityItem.fromMap(Map<String, dynamic> json) =>
      AvailabilityItem(
        availabilityId: json["availability_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        availabilityStatus: json["availability_status"],
        availabilityReason: json["availability_reason"],
      );

  Map<String, dynamic> toMap() => {
        "availability_id": availabilityId,
        "product_id": productId,
        "product_name": productName,
        "availability_status": availabilityStatus,
        "availability_reason": availabilityReason,
      };
}
