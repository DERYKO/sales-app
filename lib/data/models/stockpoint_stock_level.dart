import 'package:jaguar_orm/jaguar_orm.dart';

class StockpointStockLevel {
  @PrimaryKey(auto: false)
  int productId;
  @Column(
    isNullable: true,
  )
  int storeId;
  @Column(
    isNullable: true,
  )
  String category;
  @Column(
    isNullable: true,
  )
  String productDesc;
  @Column(
    isNullable: true,
  )
  String quantity;
  @Column(isNullable: true)
  String batchnumber;

  StockpointStockLevel({
    this.storeId,
    this.category,
    this.productId,
    this.productDesc,
    this.quantity,
    this.batchnumber,
  });

  factory StockpointStockLevel.fromMap(Map<String, dynamic> json) =>
      StockpointStockLevel(
        storeId: json["store_id"] == null ? null : json["store_id"],
        category: json["category"] == null ? null : json["category"],
        productId: json["product_id"] == null ? null : json["product_id"],
        productDesc: json["product_desc"] == null ? null : json["product_desc"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        batchnumber: json["batchnumber"] == null ? null : json["batchnumber"],
      );

  Map<String, dynamic> toMap() => {
        "store_id": storeId == null ? null : storeId,
        "category": category == null ? null : category,
        "product_id": productId == null ? null : productId,
        "product_desc": productDesc == null ? null : productDesc,
        "quantity": quantity == null ? null : quantity,
        "batchnumber": batchnumber == null ? null : batchnumber,
      };
}
