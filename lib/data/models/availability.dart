import 'package:jaguar_orm/jaguar_orm.dart';

class Availability {
  @PrimaryKey(auto: true)
  int recordId;
  @Column(isNullable: true)
  DateTime entryTime;
  @Column(isNullable: true)
  String shopName;
  @Column(isNullable: true)
  String shopId;
  @Column(isNullable: true)
  String visitId;
  @Column(isNullable: true)
  double latitude;
  @Column(isNullable: true)
  double longitude;
  @Column(isNullable: true)
  bool synced;
  @Column(isNullable: true)
  bool fromServer;

  Availability({
    this.recordId,
    this.entryTime,
    this.visitId,
    this.shopName,
    this.shopId,
    this.latitude,
    this.longitude,
    this.synced,
    this.fromServer,
  });

  factory Availability.fromMap(Map<String, dynamic> json) => Availability(
        recordId: json["record_id"],
        visitId: json["visit_id"],
        entryTime: json["entry_time"] != null
            ? DateTime.parse(json["entry_time"])
            : null,
        shopName: json["shop_name"],
        shopId: json["shop_id"],
        latitude: double.parse("${json["latitude"] ?? 0.0}"),
        longitude: double.parse("${json["longitude"] ?? 0.0}"),
        synced: json["synced"],
        fromServer: json["from_server"],
      );

  Map<String, dynamic> toMap() => {
        "record_id": recordId,
        "visit_id": visitId,
        "entry_time": entryTime?.toIso8601String(),
        "shop_name": shopName,
        "shop_id": shopId,
        "latitude": latitude,
        "longitude": longitude,
        "synced": synced,
        "from_server": fromServer
      };
}
