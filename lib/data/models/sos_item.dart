import 'package:jaguar_orm/jaguar_orm.dart';

class SosItem {
  @Column(
    isNullable: true,
  )
  int productId;
  @Column(
    isNullable: true,
  )
  int sosId;
  @Column(
    isNullable: true,
  )
  String productName;
  @Column(
    isNullable: true,
  )
  String facings;
  @Column(
    isNullable: true,
  )
  String length;
  @Column(
    isNullable: true,
  )
  String position;

  SosItem({
    this.productId,
    this.sosId,
    this.productName,
    this.facings,
    this.length,
    this.position,
  });

  factory SosItem.fromMap(Map<String, dynamic> json) => SosItem(
        productId: json["product_id"],
        sosId: json["sos_id"],
        productName: json["product_name"],
        facings: "${json["facings"]}",
        length: "${json["length"]}",
        position: "${json["position"]}",
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "sos_id": sosId,
        "product_name": productName,
        "facings": facings,
        "length": length,
        "position": position,
      };
}
