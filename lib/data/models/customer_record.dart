import 'package:jaguar_orm/jaguar_orm.dart';

class CustomerRecord {
  int sellingTotalCost;
  String shopName;
  String entryType;
  String postalAddress;
  String appVersion;
  String lpoPhoto;
  double outletLatitude;
  double latitude;
  int paymentAmount;
  int addedBy;
  String shopRouteId;
  String paymentMethod;
  int poster;
  String paymentStatus;
  String shopEmail;
  int totalCost;
  String phoneNumber;
  String kraPin;
  String contactPerson;
  String callStatus;
  int du;
  int routeId;
  DateTime maturityDate;
  String regionId;
  double outletLongitude;
  double longitude;
  DateTime nextPayment;
  int locationId;
  String shopPhoneno;
  String channel;
  int shopCatId;
  DateTime orderTime;
  String orderType;
  String routeType;
  String outletPhoto;
  String battery;
  int newShop;
  String paymentId;
  int salerId;
  int shopId;

  CustomerRecord({
    this.sellingTotalCost,
    this.shopName,
    this.entryType,
    this.postalAddress,
    this.appVersion,
    this.lpoPhoto,
    this.outletLatitude,
    this.latitude,
    this.paymentAmount,
    this.addedBy,
    this.shopRouteId,
    this.paymentMethod,
    this.poster,
    this.paymentStatus,
    this.shopEmail,
    this.totalCost,
    this.phoneNumber,
    this.kraPin,
    this.contactPerson,
    this.callStatus,
    this.du,
    this.routeId,
    this.maturityDate,
    this.regionId,
    this.outletLongitude,
    this.longitude,
    this.nextPayment,
    this.locationId,
    this.shopPhoneno,
    this.channel,
    this.shopCatId,
    this.orderTime,
    this.orderType,
    this.routeType,
    this.outletPhoto,
    this.battery,
    this.newShop,
    this.paymentId,
    this.salerId,
    this.shopId,
  });

  factory CustomerRecord.fromMap(Map<String, dynamic> json) => CustomerRecord(
        sellingTotalCost: json["selling_total_cost"],
        shopName: json["shop_name"],
        entryType: json["entry_type"],
        postalAddress: json["postal_address"],
        appVersion: json["App_Version"],
        lpoPhoto: json["lpo_photo"],
        outletLatitude: json["outlet_latitude"],
        latitude: json["latitude"],
        paymentAmount: json["payment_amount"],
        addedBy: json["added_by"],
        shopRouteId: json["shop_route_id"],
        paymentMethod: json["payment_method"],
        poster: json["poster"],
        paymentStatus: json["payment_status"],
        shopEmail: json["shop_email"],
        totalCost: json["total_cost"],
        phoneNumber: json["phone_number"],
        kraPin: json["kra_pin"],
        contactPerson: json["contact_person"],
        callStatus: json["call_status"],
        du: json["du"],
        routeId: json["route_id"],
        maturityDate: json["maturity_date"] != null
            ? DateTime.parse(json["maturity_date"])
            : null,
        regionId: json["region_id"],
        outletLongitude: json["outlet_longitude"],
        longitude: json["longitude"],
        nextPayment: json["next_payment"] != null
            ? DateTime.parse(json["next_payment"])
            : null,
        locationId: json["location_id"],
        shopPhoneno: json["shop_phoneno"],
        channel: json["channel"],
        shopCatId: json["shop_cat_id"],
        orderTime: json["order_time"] != null
            ? DateTime.parse(json["order_time"])
            : null,
        orderType: json["order_type"],
        routeType: json["route_type"],
        outletPhoto: json["outlet_photo"],
        battery: json["Battery"],
        newShop: json["new_shop"],
        paymentId: json["payment_id"],
        salerId: json["saler_id"],
        shopId: json["shop_id"],
      );

  Map<String, dynamic> toMap() => {
        "selling_total_cost": sellingTotalCost,
        "shop_name": shopName,
        "entry_type": entryType,
        "postal_address": postalAddress,
        "App_Version": appVersion,
        "lpo_photo": lpoPhoto,
        "outlet_latitude": outletLatitude,
        "latitude": latitude,
        "payment_amount": paymentAmount,
        "added_by": addedBy,
        "shop_route_id": shopRouteId,
        "payment_method": paymentMethod,
        "poster": poster,
        "payment_status": paymentStatus,
        "shop_email": shopEmail,
        "total_cost": totalCost,
        "phone_number": phoneNumber,
        "kra_pin": kraPin,
        "contact_person": contactPerson,
        "call_status": callStatus,
        "du": du,
        "route_id": routeId,
        "maturity_date": maturityDate?.toIso8601String(),
        "region_id": regionId,
        "outlet_longitude": outletLongitude,
        "longitude": longitude,
        "next_payment": nextPayment?.toIso8601String(),
        "location_id": locationId,
        "shop_phoneno": shopPhoneno,
        "channel": channel,
        "shop_cat_id": shopCatId,
        "order_time": orderTime?.toIso8601String(),
        "order_type": orderType,
        "route_type": routeType,
        "outlet_photo": outletPhoto,
        "Battery": battery,
        "new_shop": newShop,
        "payment_id": paymentId,
        "saler_id": salerId,
        "shop_id": shopId,
      };
}
