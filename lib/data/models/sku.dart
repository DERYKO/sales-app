class Sku {
  String productDesc;
  String totalSales;
  String quantity;

  Sku({
    this.productDesc,
    this.totalSales,
    this.quantity,
  });

  factory Sku.fromMap(Map<String, dynamic> json) => Sku(
        productDesc: json["product_desc"],
        totalSales: json["total_sales"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "product_desc": productDesc,
        "total_sales": totalSales,
        "quantity": quantity,
      };
}
