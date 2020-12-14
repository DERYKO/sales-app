import 'package:jaguar_orm/jaguar_orm.dart';

class ProductUpdate {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  int shopId;
  @Column(isNullable: true)
  int repId;
  @Column(isNullable: true)
  int productId;
  @Column(isNullable: true)
  String updateType;
  @Column(isNullable: true)
  String visitId;
  @Column(isNullable: true)
  DateTime expiryDate;
  @Column(isNullable: true)
  int quantity;
  @Column(isNullable: true)
  String photo;
  @Column(isNullable: true)
  String notes;
  @Column(isNullable: true)
  String latitude;
  @Column(isNullable: true)
  String longitude;
  @Column(isNullable: true)
  DateTime entryTime;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedTime;
  @Column(isNullable: true)
  bool synced;
  @Column(isNullable: true)
  bool fromServer;

  ProductUpdate({
    this.id,
    this.shopId,
    this.repId,
    this.productId,
    this.updateType,
    this.expiryDate,
    this.quantity,
    this.visitId,
    this.photo,
    this.notes,
    this.latitude,
    this.longitude,
    this.entryTime,
    this.createdAt,
    this.updatedTime,
    this.synced = false,
    this.fromServer = false,
  });

  factory ProductUpdate.fromMap(Map<String, dynamic> json) => ProductUpdate(
        id: json["id"],
        shopId: json["shop_id"],
        repId: json["rep_id"],
        productId: json["product_id"],
        updateType: json["update_type"],
        expiryDate: json["expiry_date"] != null
            ? DateTime.parse(json["expiry_date"])
            : null,
        quantity: json["quantity"],
        visitId: json["visitid"],
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
        updatedTime: json["updated_time"] == null
            ? null
            : DateTime.parse(json["updated_time"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "shop_id": shopId,
        "rep_id": repId,
        "product_id": productId,
        "update_type": updateType,
        "expiry_date": expiryDate?.toIso8601String(),
        "quantity": quantity,
        "photo": photo,
        "notes": notes,
        "viditid": visitId,
        "latitude": latitude,
        "longitude": longitude,
        "entry_time": entryTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_time": updatedTime,
        "synced": synced,
        "from_server": fromServer,
      };
}
