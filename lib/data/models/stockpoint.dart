import 'package:jaguar_orm/jaguar_orm.dart';

class Stockpoint {
  @PrimaryKey(auto: false)
  int id;
  @Column(isNullable: true)
  String shopName;
  @Column(isNullable: true)
  String shopCatName;
  @Column(isNullable: true)
  int shopCatId;
  @Column(isNullable: true)
  String locationName;
  @Column(isNullable: true)
  String shopPhoneno;
  @Column(isNullable: true)
  String contactPerson;
  @Column(isNullable: true)
  String photo;
  @Column(isNullable: true)
  String verified;
  @Column(isNullable: true)
  int status;
  @Column(isNullable: true)
  String createdAt;
  @Column(isNullable: true)
  String slatitude;
  @Column(isNullable: true)
  String slongitude;

  Stockpoint(
      {this.id,
      this.shopName,
      this.shopCatName,
      this.shopCatId,
      this.locationName,
      this.shopPhoneno,
      this.contactPerson,
      this.photo,
      this.verified,
      this.status,
      this.createdAt,
      this.slatitude,
      this.slongitude});

  Stockpoint.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    shopName = json['shop_name'];
    shopCatName = json['shop_cat_name'];
    shopCatId = json['shop_cat_id'];
    locationName = json['location_name'];
    shopPhoneno = json['shop_phoneno'];
    contactPerson = json['contact_person'];
    photo = json['photo'];
    verified = json['verified'];
    status = json['status'];
    createdAt = json['created_at'];
    slatitude = json['slatitude'];
    slongitude = json['slongitude'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_name'] = this.shopName;
    data['shop_cat_name'] = this.shopCatName;
    data['shop_cat_id'] = this.shopCatId;
    data['location_name'] = this.locationName;
    data['shop_phoneno'] = this.shopPhoneno;
    data['contact_person'] = this.contactPerson;
    data['photo'] = this.photo;
    data['verified'] = this.verified;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['slatitude'] = this.slatitude;
    data['slongitude'] = this.slongitude;
    return data;
  }
}
