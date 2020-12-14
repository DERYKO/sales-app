import 'package:jaguar_orm/jaguar_orm.dart';

class Sod {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  int repId;
  @Column(isNullable: true)
  int shopId;
  @Column(isNullable: true)
  String brand;
  @Column(isNullable: true)
  String competitor;
  @Column(isNullable: true)
  String displayType;
  @Column(isNullable: true)
  int quantity;
  @Column(isNullable: true)
  String photo;
  @Column(isNullable: true)
  String notes;
  @Column(isNullable: true)
  String visitid;
  @Column(isNullable: true)
  String latitude;
  @Column(isNullable: true)
  String longitude;
  @Column(isNullable: true)
  DateTime entryTime;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;
  bool synced;
  bool fromServer;

  Sod({
    this.id,
    this.repId,
    this.shopId,
    this.brand,
    this.competitor,
    this.displayType,
    this.quantity,
    this.photo,
    this.notes,
    this.visitid,
    this.latitude,
    this.longitude,
    this.entryTime,
    this.createdAt,
    this.updatedAt,
    this.synced = true,
    this.fromServer = true,
  });

  factory Sod.fromMap(Map<String, dynamic> json) => Sod(
        id: json["id"],
        repId: json["rep_id"],
        shopId: json["shop_id"],
        brand: json["brand"],
        visitid: json["visitid"],
        competitor: json["competitor"],
        displayType: json["display_type"],
        quantity: json["quantity"],
        photo: json["photo"],
        notes: json["notes"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        entryTime: json["entry_time"] != null
            ? DateTime.parse(json["entry_time"])
            : null,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "rep_id": repId,
        "shop_id": shopId,
        "brand": brand,
        "competitor": competitor,
        "display_type": displayType,
        "quantity": quantity,
        "photo": photo,
        "notes": notes,
        "latitude": latitude,
        "longitude": longitude,
        "entry_time": entryTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
