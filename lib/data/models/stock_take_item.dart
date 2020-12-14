import 'package:jaguar_orm/jaguar_orm.dart';

class StockTakeItem {
  @Column(isNullable: true)
  int stockTakeId;
  @Column(isNullable: true)
  int productId;
  @Column(isNullable: true)
  int quantity;
  @Column(isNullable: true)
  String packaging;

  StockTakeItem({
    this.stockTakeId,
    this.productId,
    this.quantity,
    this.packaging,
  });

  factory StockTakeItem.fromMap(Map<String, dynamic> json) => StockTakeItem(
        stockTakeId: json["stock_take_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        packaging: json["packaging"],
      );

  Map<String, dynamic> toMap() => {
        "stock_take_id": stockTakeId,
        "product_id": productId,
        "quantity": quantity,
        "packaging": packaging,
      };
}
