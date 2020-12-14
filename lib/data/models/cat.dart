import 'package:jaguar_orm/jaguar_orm.dart';

class Cat {
  String productCategory;
  String totalSales;
  String quantity;

  Cat({
    this.productCategory,
    this.totalSales,
    this.quantity,
  });

  factory Cat.fromMap(Map<String, dynamic> json) => Cat(
        productCategory: json["product_category"],
        totalSales: json["total_sales"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "product_category": productCategory,
        "total_sales": totalSales,
        "quantity": quantity,
      };
}
