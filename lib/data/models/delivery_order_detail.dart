import 'package:jaguar_orm/jaguar_orm.dart';

class DeliveryOrderDetail {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  int orderId;
  @Column(isNullable: true)
  String productDescription;
  @Column(isNullable: true)
  int productId;
  @Column(isNullable: true)
  int quantity;
  @Column(isNullable: true)
  String productPackaging;
  @Column(isNullable: true)
  String sellingTotalcost;

  DeliveryOrderDetail({
    this.id,
    this.orderId,
    this.productDescription,
    this.productId,
    this.quantity,
    this.productPackaging,
    this.sellingTotalcost,
  });

  factory DeliveryOrderDetail.fromMap(Map<String, dynamic> json) =>
      DeliveryOrderDetail(
        id: json["id"],
        orderId: json["order_id"],
        productDescription: json["product_description"],
        productId: json["product_id"],
        quantity: json["quantity"],
        productPackaging: json["product_packaging"],
        sellingTotalcost: json["selling_totalcost"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order_id": orderId,
        "product_description": productDescription,
        "product_id": productId,
        "quantity": quantity,
        "product_packaging": productPackaging,
        "selling_totalcost": sellingTotalcost,
      };
}
