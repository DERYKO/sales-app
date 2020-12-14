import 'package:jaguar_orm/jaguar_orm.dart';

class SkipRecord {
  @Column(isNullable: true)
  String skipReason;
  @Column(isNullable: true)
  double latitude;
  @Column(isNullable: true)
  String visitId;
  @Column(isNullable: true)
  DateTime nextVisitDate;
  @Column(isNullable: true)
  String callStatus;
  @Column(isNullable: true)
  String routeId;
  @Column(isNullable: true)
  double longitude;
  @Column(isNullable: true)
  String skipNotes;
  @Column(isNullable: true)
  String routeType;
  @Column(isNullable: true)
  String battery;
  @Column(isNullable: true)
  int newShop;
  @PrimaryKey(auto: false)
  String orderTime;
  @Column(isNullable: true)
  int salerId;
  @Column(isNullable: true)
  int shopId;
  @Column(isNullable: true)
  bool fromServer;
  @Column(isNullable: true)
  bool synced;

  SkipRecord({
    this.skipReason,
    this.nextVisitDate,
    this.callStatus,
    this.visitId,
    this.routeId,
    this.latitude,
    this.longitude,
    this.skipNotes,
    this.orderTime,
    this.routeType,
    this.battery,
    this.newShop,
    this.salerId,
    this.shopId,
    this.fromServer = false,
    this.synced = false,
  });

  factory SkipRecord.fromMap(Map<String, dynamic> json) => SkipRecord(
        skipReason: json["skip_reason"],
        latitude: json["latitude"],
        visitId: json["visitid"],
        nextVisitDate: json["next_visit_date"] != null
            ? DateTime.parse(json["next_visit_date"])
            : null,
        callStatus: json["call_status"],
        routeId: json["route_id"],
        longitude: json["longitude"],
        skipNotes: json["skip_notes"],
        orderTime: json["order_time"],
        routeType: json["route_type"],
        battery: json["Battery"],
        newShop: json["new_shop"],
        salerId: json["saler_id"],
        shopId: json["shop_id"],
      );

  Map<String, dynamic> toMap() => {
        "skip_reason": skipReason,
        "latitude": latitude,
        "visitid": visitId,
        "next_visit_date": nextVisitDate?.toIso8601String(),
        "call_status": callStatus,
        "route_id": routeId,
        "longitude": longitude,
        "skip_notes": skipNotes,
        "order_time": orderTime,
        "route_type": routeType,
        "Battery": battery,
        "new_shop": newShop,
        "saler_id": salerId,
        "shop_id": shopId,
      };
}
