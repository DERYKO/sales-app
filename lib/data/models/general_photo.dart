import 'package:jaguar_orm/jaguar_orm.dart';

class GeneralPhoto {
  @PrimaryKey(auto: true)
  int id;
  @Column(
    isNullable: true,
  )
  int salerId;
  @Column(
    isNullable: true,
  )
  int shopId;
  @Column(
    isNullable: true,
  )
  String imageCategory;
  @Column(
    isNullable: true,
  )
  String imageNotes;
  @Column(
    isNullable: true,
  )
  String visitid;
  @Column(
    isNullable: true,
  )
  String imagePhoto;
  @Column(
    isNullable: true,
  )
  int activityId;
  @Column(
    isNullable: true,
  )
  String productCategory;
  @Column(
    isNullable: true,
  )
  String brandName;
  @Column(
    isNullable: true,
  )
  String longitude;
  @Column(
    isNullable: true,
  )
  String latitude;
  @Column(
    isNullable: true,
  )
  String imageAddress;
  @Column(
    isNullable: true,
  )
  DateTime imageTime;
  @Column(
    isNullable: true,
  )
  DateTime createdAt;
  @Column(
    isNullable: true,
  )
  DateTime updatedAt;
  bool synced;
  bool fromServer;

  GeneralPhoto({
    this.id,
    this.salerId,
    this.shopId,
    this.visitid,
    this.imageCategory,
    this.imageNotes,
    this.imagePhoto,
    this.activityId,
    this.productCategory,
    this.brandName,
    this.longitude,
    this.latitude,
    this.imageAddress,
    this.imageTime,
    this.createdAt,
    this.updatedAt,
    this.synced = false,
    this.fromServer = false,
  });

  factory GeneralPhoto.fromMap(Map<String, dynamic> json) => GeneralPhoto(
        id: json["id"],
        salerId: json["saler_id"],
        shopId: json["shop_id"],
        visitid: json["visitid"],
        imageCategory: json["image_category"],
        imageNotes: json["image_notes"],
        imagePhoto: json["image_photo"],
        activityId: json["activity_id"],
        productCategory: json["product_category"],
        brandName: json["brand_name"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        imageAddress: json["image_address"],
        imageTime: json["image_time"] != null
            ? DateTime.parse(json["image_time"])
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
        "saler_id": salerId,
        "shop_id": shopId,
        "visitid": visitid,
        "image_category": imageCategory,
        "image_notes": imageNotes,
        "image_photo": imagePhoto,
        "activity_id": activityId,
        "product_category": productCategory,
        "brand_name": brandName,
        "longitude": longitude,
        "latitude": latitude,
        "image_address": imageAddress,
        "image_time": imageTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
