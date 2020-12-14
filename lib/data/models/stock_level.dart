import 'package:jaguar_orm/jaguar_orm.dart';

class StockLevel {
  int productId;
  int storeId;
  String category;
  String productName;
  String quantity;

  StockLevel({
    this.storeId,
    this.category,
    this.productId,
    this.productName,
    this.quantity,
  });

  StockLevel.fromMap(Map<String, dynamic> json) {
    storeId = json['store_id'];
    category = json['category'];
    productId = json['product_id'];
    productName = json['product_name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['category'] = this.category;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['quantity'] = this.quantity;
    return data;
  }
}
