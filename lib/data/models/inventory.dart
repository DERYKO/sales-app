import 'package:jaguar_orm/jaguar_orm.dart';

class Inventory {
  String quantity;
  int productId;
  int storeId;
  String batchnumber;

  Inventory({this.quantity, this.productId, this.storeId, this.batchnumber});

  Inventory.fromMap(Map<String, dynamic> json) {
    quantity = json['quantity'];
    productId = json['product_id'];
    storeId = json['store_id'];
    batchnumber = json['batchnumber'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['product_id'] = this.productId;
    data['store_id'] = this.storeId;
    data['batchnumber'] = this.batchnumber;
    return data;
  }
}
