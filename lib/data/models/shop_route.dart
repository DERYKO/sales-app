import 'package:jaguar_orm/jaguar_orm.dart';

class ShopRoute {
  int shopId;
  int routeId;

  ShopRoute({
    this.shopId,
    this.routeId,
  });

  factory ShopRoute.fromMap(Map<String, dynamic> json) => ShopRoute(
        shopId: json["shop_id"],
        routeId: json["route_id"],
      );

  Map<String, dynamic> toMap() => {
        "shop_id": shopId,
        "route_id": routeId,
      };
}
