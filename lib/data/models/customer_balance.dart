import 'package:jaguar_orm/jaguar_orm.dart';

class CustomerBalance {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  int shopId;
  @Column(isNullable: true)
  String shopName;
  @Column(isNullable: true)
  int orderId;
  @Column(isNullable: true)
  String amount;
  @Column(isNullable: true)
  String amountpaid;
  @Column(isNullable: true)
  bool synced;

  CustomerBalance({
    this.shopId,
    this.shopName,
    this.orderId,
    this.amount,
    this.amountpaid,
    this.synced = false,
  });

  factory CustomerBalance.fromMap(Map<String, dynamic> json) => CustomerBalance(
        shopId: json["shop_id"],
        shopName: json["shop_name"],
        orderId: json["order_id"],
        amount: json["amount"],
        amountpaid: json["amountpaid"],
        synced: json["synced"],
      );

  Map<String, dynamic> toMap() => {
        "shop_id": shopId,
        "shop_name": shopName,
        "order_id": orderId,
        "amount": amount,
        "amountpaid": amountpaid,
        "synced": synced,
      };
}
