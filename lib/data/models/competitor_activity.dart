import 'package:jaguar_orm/jaguar_orm.dart';

class CompetitorActivity {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  int salerId;
  @Column(isNullable: true)
  int shopId;
  @Column(isNullable: true)
  String productName;
  @Column(isNullable: true)
  String productSku;
  @Column(isNullable: true)
  int companyId;
  @Column(isNullable: true)
  String mechanism;
  @Column(isNullable: true)
  String beforeValue;
  @Column(isNullable: true)
  String afterValue;
  @Column(isNullable: true)
  String competitor;
  @Column(isNullable: true)
  String visitId;
  @Column(isNullable: true)
  String notes;
  @Column(isNullable: true)
  String photo;
  @Column(isNullable: true)
  int csku;
  @Column(isNullable: true)
  DateTime entryTime;
  @Column(isNullable: true)
  String latitude;
  @Column(isNullable: true)
  String longitude;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;
  bool synced;
  bool fromServer;

  CompetitorActivity({
    this.id,
    this.salerId,
    this.shopId,
    this.productName,
    this.productSku,
    this.companyId,
    this.mechanism,
    this.beforeValue,
    this.afterValue,
    this.competitor,
    this.notes,
    this.visitId,
    this.csku,
    this.photo,
    this.entryTime,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.synced = false,
    this.fromServer = false,
  });

  factory CompetitorActivity.fromMap(Map<String, dynamic> json) =>
      CompetitorActivity(
        id: json["id"],
        salerId: json["saler_id"],
        shopId: json["shop_id"],
        productName: json["product_name"],
        productSku: json["product_sku"],
        companyId: json["company_id"],
        mechanism: json["mechanism"],
        beforeValue: json["before_value"],
        afterValue: json["after_value"],
        competitor: json["competitor"],
        csku: json["csku"],
        notes: json["notes"],
        photo: json["photo"],
        visitId: json["visitid"],
        entryTime: json["entry_time"] != null
            ? DateTime.parse(json["entry_time"])
            : null,
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "saler_id": salerId,
        "shop_id": shopId,
        "product_name": productName,
        "product_sku": productSku,
        "company_id": companyId,
        "mechanism": mechanism,
        "before_value": beforeValue,
        "after_value": afterValue,
        "competitor": competitor,
        "notes": notes,
        "photo": photo,
        "csku": csku,
        "visitid": visitId,
        "entry_time": entryTime?.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
