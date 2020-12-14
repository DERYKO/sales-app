import 'package:jaguar_orm/jaguar_orm.dart';

class Delivery {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  int scheduledDeliveryId;
  @Column(isNullable: true)
  int orderId;
  @Column(isNullable: true)
  DateTime deliveryTime;
  @Column(isNullable: true)
  DateTime orderTime;
  @Column(isNullable: true)
  int shopId;
  @Column(isNullable: true)
  String deliveryNotes;
  @Column(isNullable: true)
  String receivedsignature;
  @Column(isNullable: true)
  String shopName;
  @Column(isNullable: true)
  String shopLat;
  @Column(isNullable: true)
  String shopLon;
  @Column(isNullable: true)
  String photo;
  @Column(isNullable: true)
  String name;
  bool synced;
  bool fromServer;

  Delivery({
    this.id,
    this.scheduledDeliveryId,
    this.orderId,
    this.deliveryTime,
    this.deliveryNotes,
    this.receivedsignature,
    this.shopName,
    this.shopLat,
    this.orderTime,
    this.shopId,
    this.shopLon,
    this.name,
    this.photo,
    this.synced = false,
    this.fromServer = false,
  });

  factory Delivery.fromMap(Map<String, dynamic> json) => Delivery(
        id: json["id"],
        orderId: json["order_id"],
        deliveryTime: json["delivery_time"] != null
            ? DateTime.parse(json["delivery_time"])
            : null,
        deliveryNotes: json["delivery_notes"],
        receivedsignature: json["receivedsignature"],
        shopName: json["shop_name"],
        photo: json["photo"],
        shopId: json["shop_id"],
        orderTime: json["order_time"] != null
            ? DateTime.parse(json["order_time"])
            : null,
        shopLat: json["shop_lat"],
        shopLon: json["shop_lon"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order_id": orderId,
        "delivery_time": deliveryTime?.toIso8601String(),
        "delivery_notes": deliveryNotes,
        "receivedsignature": receivedsignature,
        "shop_name": shopName,
        "shop_id": shopId,
        "photo": photo,
        "order_time": orderTime?.toIso8601String(),
        "shop_lat": shopLat,
        "shop_lon": shopLon,
        "name": name,
      };
}
