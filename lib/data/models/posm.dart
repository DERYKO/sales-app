import 'package:jaguar_orm/jaguar_orm.dart';

class Posm {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  String shopName;
  @Column(isNullable: true)
  String name;
  @Column(isNullable: true)
  int shopId;
  @Column(isNullable: true)
  String visitId;
  @Column(isNullable: true)
  int itemId;
  @Column(isNullable: true)
  String productName;
  @Column(isNullable: true)
  String itemname;
  @Column(isNullable: true)
  String availability;
  @Column(isNullable: true)
  String stocked;
  @Column(isNullable: true)
  String visibility;
  @Column(isNullable: true)
  String notes;
  @Column(isNullable: true)
  DateTime entryTime;
  @Column(isNullable: true)
  double latitude;
  @Column(isNullable: true)
  double longitude;
  @Column(isNullable: true)
  bool synced;
  @Column(isNullable: true)
  bool fromServer;

  Posm({
    this.id,
    this.shopId,
    this.itemId,
    this.shopName,
    this.visitId,
    this.name,
    this.productName,
    this.itemname,
    this.availability,
    this.stocked,
    this.visibility,
    this.notes,
    this.entryTime,
    this.latitude,
    this.longitude,
    this.synced,
    this.fromServer,
  });

  factory Posm.fromMap(Map<String, dynamic> json) => Posm(
        id: json["id"],
        shopId: json["shop_id"],
        itemId: json["item_id"],
        shopName: json["shop_name"],
        visitId: json["visit_id"],
        name: json["name"],
        productName: json["product_name"],
        itemname: json["itemname"],
        availability: json["availability"],
        stocked: json["stocked"],
        visibility: json["visibility"],
        notes: json["notes"],
        entryTime: json["entry_time"] != null
            ? DateTime.parse(json["entry_time"])
            : null,
        latitude: double.parse("${json["latitude"] ?? 0.0}"),
        longitude: double.parse("${json["longitude"] ?? 0.0}"),
        synced: json["synced"],
        fromServer: json["from_server"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "shop_id": shopId,
        "item_id": itemId,
        "shop_name": shopName,
        "visit_id": visitId,
        "name": name,
        "product_name": productName,
        "itemname": itemname,
        "availability": availability,
        "stocked": stocked,
        "visibility": visibility,
        "notes": notes,
        "entry_time": entryTime?.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "synced": synced,
        "from_server": fromServer
      };
}
