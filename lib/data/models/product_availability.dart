import 'package:jaguar_orm/jaguar_orm.dart';

class ProductAvailability {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  String visitid;
  @Column(isNullable: true)
  int repId;
  @Column(isNullable: true)
  int outletId;
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
  @Column(isNullable: true)
  bool fromServer;
  @Column(isNullable: true)
  bool synced;

  ProductAvailability({
    this.id,
    this.visitid,
    this.repId,
    this.outletId,
    this.latitude,
    this.longitude,
    this.entryTime,
    this.createdAt,
    this.updatedAt,
    this.fromServer = false,
    this.synced = false,
  });

  factory ProductAvailability.fromMap(Map<String, dynamic> json) =>
      ProductAvailability(
        id: json["id"],
        visitid: json["visitid"],
        repId: json["rep_id"],
        outletId: json["outlet_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        entryTime: json["entry_time"] == null
            ? null
            : DateTime.parse(json["entry_time"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "visitid": visitid,
        "rep_id": repId,
        "outlet_id": outletId,
        "latitude": latitude,
        "longitude": longitude,
        "entry_time": entryTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
