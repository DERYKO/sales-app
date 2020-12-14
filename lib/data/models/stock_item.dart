import 'package:jaguar_orm/jaguar_orm.dart';

class StockItem {
  int productId;
  int stockId;
  @Column(isNullable: true)
  String productName;
  @Column(isNullable: true)
  String productDesc;
  @Column(isNullable: true)
  String unit;
  @Column(isNullable: true)
  String batchnumber;
  int quantity;
  double price;
  int crtQnty;

  StockItem({
    this.productId,
    this.productName,
    this.productDesc,
    this.unit,
    this.quantity,
    this.stockId,
    this.batchnumber,
    this.price,
    this.crtQnty,
  });

  StockItem.fromMap(Map<String, dynamic> json) {
    productId = json['product_id'];
    stockId = json['stock_id'];
    productName = json['product_name'];
    productDesc = json['product_desc'];
    batchnumber = json['batchnumber'];
    unit = json['unit'];
    quantity = json['quantity'];
    price = json['price'];
    crtQnty = json['crt_qnty'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_desc'] = this.productDesc;
    data['batchnumber'] = this.batchnumber;
    data['unit'] = this.unit;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['crt_qnty'] = this.crtQnty;
    return data;
  }
}
