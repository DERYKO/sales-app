import 'package:jaguar_orm/jaguar_orm.dart';

class Customer {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  String shopId;
  @Column(isNullable: true)
  int userId;
  @Column(isNullable: true)
  String qrcode;
  @Column(isNullable: true)
  int regionId;
  @Column(isNullable: true)
  int locationId;
  @Column(isNullable: true)
  String shopName;
  @Column(isNullable: true)
  String address;
  @Column(isNullable: true)
  String location;
  @Column(isNullable: true)
  String shopPhoneno;
  @Column(isNullable: true)
  String customerType;
  @Column(isNullable: true)
  String groupName;
  @Column(isNullable: true)
  int creditLimit;
  @Column(isNullable: true)
  String tier;
  @Column(isNullable: true)
  String slatitude;
  @Column(isNullable: true)
  String slongitude;
  @Column(isNullable: true)
  String visitTime;
  @Column(isNullable: true)
  String updatedTime;
  @Column(isNullable: true)
  String shopEmail;
  @Column(isNullable: true)
  String specificLocation;
  @Column(isNullable: true)
  int shopCatId;
  @Column(isNullable: true)
  int shopSubCatId;
  @Column(isNullable: true)
  int groupId;
  @Column(isNullable: true)
  int shopLocationId;
  @Column(isNullable: true)
  String kraPin;
  @Column(isNullable: true)
  int addedBy;
  @Column(isNullable: true)
  String contactPerson;
  @Column(isNullable: true)
  String postalAddress;
  @Column(isNullable: true)
  int status;
  @Column(isNullable: true)
  String shopStatust;
  @Column(isNullable: true)
  String verified;
  @Column(isNullable: true)
  int verifiedby;
  @Column(isNullable: true)
  String verificationDate;
  @Column(isNullable: true)
  String photo;
  @Column(isNullable: true)
  String loyaltyEnrolledAt;
  @Column(isNullable: true)
  String pezeshaEnrolledAt;
  @Column(isNullable: true)
  String createdAt;
  @Column(isNullable: true)
  String updatedAt;
  @Column(isNullable: true)
  int routeId;
  @Column(isNullable: true)
  int orderId;
  @Column(isNullable: true)
  bool synced;
  @Column(isNullable: true)
  bool updated;
  @Column(isNullable: true)
  bool fromServer;

  Customer({
    this.id,
    this.shopId,
    this.userId,
    this.qrcode,
    this.groupId,
    this.regionId,
    this.locationId,
    this.shopName,
    this.location,
    this.address,
    this.shopPhoneno,
    this.customerType,
    this.groupName,
    this.creditLimit,
    this.tier,
    this.updatedTime,
    this.slatitude,
    this.slongitude,
    this.visitTime,
    this.shopEmail,
    this.specificLocation,
    this.shopCatId,
    this.shopSubCatId,
    this.shopLocationId,
    this.kraPin,
    this.addedBy,
    this.contactPerson,
    this.postalAddress,
    this.status,
    this.shopStatust,
    this.verified,
    this.verifiedby,
    this.verificationDate,
    this.photo,
    this.loyaltyEnrolledAt,
    this.pezeshaEnrolledAt,
    this.createdAt,
    this.updatedAt,
    this.routeId,
    this.orderId,
    this.synced,
    this.fromServer,
    this.updated,
  });

  Customer.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['id'] != null ? "${json['id']}" : null;
    userId = json['user_id'];
    qrcode = json['qrcode'];
    regionId = json['region_id'];
    locationId = json['location_id'];
    shopName = json['shop_name'];
    location = json['location'];
    shopPhoneno = json['shop_phoneno'];
    customerType = json['customer_type'];
    groupName = json['group_name'];
    creditLimit = json['credit_limit'];
    address = json['address'];
    tier = json['tier'];
    slatitude = json['slatitude'];
    slongitude = json['slongitude'];
    visitTime = json['visit_time'];
    updatedTime = json['updated_time'];
    shopEmail = json['shop_email'];
    specificLocation = json['specific_location'];
    shopCatId = json['shop_cat_id'];
    shopSubCatId = json['shop_subcat_id'];
    shopLocationId = json['shop_location_id'];
    kraPin = json['kra_pin'];
    addedBy = json['added_by'];
    contactPerson = json['contact_person'];
    postalAddress = json['postal_address'];
    status = json['status'];
    groupId = json['group_id'];
    shopStatust = json['shop_statust'];
    verified = json['verified'];
    verifiedby = json['verifiedby'];
    verificationDate = json['verification_date'];
    photo = json['photo'];
    loyaltyEnrolledAt = json['loyalty_enrolled_at'];
    pezeshaEnrolledAt = json['pezesha_enrolled_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    routeId = json['route_id'];
    orderId = json['order_id'];
    synced = json['synced'];
    fromServer = json["from_server"];
    updated = json["updated"];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_id'] = this.shopId;
    data['user_id'] = this.userId;
    data['qrcode'] = this.qrcode;
    data['region_id'] = this.regionId;
    data['location_id'] = this.locationId;
    data['shop_name'] = this.shopName;
    data['location'] = this.location;
    data['updated_time'] = this.updatedTime;
    data['shop_phoneno'] = this.shopPhoneno;
    data['customer_type'] = this.customerType;
    data['group_name'] = this.groupName;
    data['credit_limit'] = this.creditLimit;
    data['address'] = this.address;
    data['tier'] = this.tier;
    data['group_id'] = this.groupId;
    data['slatitude'] = this.slatitude;
    data['slongitude'] = this.slongitude;
    data['visit_time'] = this.visitTime;
    data['shop_email'] = this.shopEmail;
    data['specific_location'] = this.specificLocation;
    data['shop_cat_id'] = this.shopCatId;
    data['shop_subcat_id'] = this.shopSubCatId;
    data['shop_location_id'] = this.shopLocationId;
    data['kra_pin'] = this.kraPin;
    data['added_by'] = this.addedBy;
    data['contact_person'] = this.contactPerson;
    data['postal_address'] = this.postalAddress;
    data['status'] = this.status;
    data['shop_statust'] = this.shopStatust;
    data['verified'] = this.verified;
    data['verifiedby'] = this.verifiedby;
    data['verification_date'] = this.verificationDate;
    data['photo'] = this.photo;
    data['loyalty_enrolled_at'] = this.loyaltyEnrolledAt;
    data['pezesha_enrolled_at'] = this.pezeshaEnrolledAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['route_id'] = this.routeId;
    data['order_id'] = this.orderId;
    data["synced"] = this.synced;
    data["from_server"] = this.fromServer;
    data["updated"] = this.updated;
    return data;
  }
}
