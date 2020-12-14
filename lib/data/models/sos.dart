import 'package:jaguar_orm/jaguar_orm.dart';

class Sos {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  int shopId;
  @Column(isNullable: true)
  String shopName;
  @Column(isNullable: true)
  int repId;
  @Column(isNullable: true)
  String productCategory;
  @Column(isNullable: true)
  String totalFacings;
  @Column(isNullable: true)
  String facings;
  @Column(isNullable: true)
  String totalLength;
  @Column(isNullable: true)
  String photo;
  @Column(isNullable: true)
  String sosNotes;
  @Column(isNullable: true)
  DateTime entryTime;
  bool synced;
  bool fromServer;

  Sos({
    this.id,
    this.shopId,
    this.shopName,
    this.repId,
    this.productCategory,
    this.totalFacings,
    this.facings,
    this.totalLength,
    this.sosNotes,
    this.photo,
    this.entryTime,
    this.synced = false,
    this.fromServer = false,
  });

  factory Sos.fromMap(Map<String, dynamic> json) => Sos(
        id: json["id"],
        shopId: json["shop_id"],
        repId: json["rep_id"],
        productCategory: json["product_category"],
        totalFacings: "${json["total_facings"]}",
        photo: json["photo"],
        facings: "${json["facings"]}",
        totalLength: "${json["total_length"]}",
        sosNotes: json["sos_notes"],
        entryTime: DateTime.parse(json["entry_time"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "shop_id": shopId,
        "rep_id": repId,
        "product_category": productCategory,
        "total_facings": totalFacings,
        "photo": photo,
        "facings": facings,
        "total_length": totalLength,
        "sos_notes": sosNotes,
        "entry_time": entryTime.toIso8601String(),
      };
}
