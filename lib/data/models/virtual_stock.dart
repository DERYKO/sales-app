import 'package:jaguar_orm/jaguar_orm.dart';

class VirtualStock {
  @PrimaryKey(auto: true)
  int id;
  int productId;
  int storeId;
  String category;
  String productDesc;
  String quantity;
  @Column(isNullable: true)
  String batchnumber;

  VirtualStock({
    this.id,
    this.storeId,
    this.category,
    this.productId,
    this.productDesc,
    this.quantity,
    this.batchnumber,
  });

  factory VirtualStock.fromMap(Map<String, dynamic> json) => VirtualStock(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        category: json["category"] == null ? null : json["category"],
        productId: json["product_id"] == null ? null : json["product_id"],
        productDesc: json["product_desc"] == null ? null : json["product_desc"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        batchnumber: json["batchnumber"] == null ? null : json["batchnumber"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "category": category == null ? null : category,
        "product_id": productId == null ? null : productId,
        "product_desc": productDesc == null ? null : productDesc,
        "quantity": quantity == null ? null : quantity,
        "batchnumber": batchnumber == null ? null : batchnumber,
      };
}
