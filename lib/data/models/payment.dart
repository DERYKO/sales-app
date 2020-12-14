import 'package:jaguar_orm/jaguar_orm.dart';

class Payment {
  @PrimaryKey(auto: false)
  int collectionId;
  @Column(isNullable: true)
  String outletId;
  @Column(isNullable: true)
  String shopName;
  @Column(isNullable: true)
  String paymentMethod;
  @Column(isNullable: true)
  String amountPaid;
  @Column(isNullable: true)
  String paymentRef;
  @Column(isNullable: true)
  String chequePhoto;
  @Column(isNullable: true)
  DateTime recordTime;
  @Column(isNullable: true)
  DateTime banked;

  Payment({
    this.collectionId,
    this.outletId,
    this.shopName,
    this.paymentMethod,
    this.amountPaid,
    this.paymentRef,
    this.chequePhoto,
    this.recordTime,
    this.banked,
  });

  factory Payment.fromMap(Map<String, dynamic> json) => Payment(
        collectionId: json["collection_id"],
        outletId: json["outlet_id"],
        shopName: json["shop_name"],
        paymentMethod: json["payment_method"],
        amountPaid: json["amount_paid"],
        paymentRef: json["payment_ref"],
        chequePhoto: json["cheque_photo"],
        recordTime: json["record_time"] != null
            ? DateTime.parse(json["record_time"])
            : null,
        banked: json["banked"] != null ? DateTime.parse(json["banked"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "collection_id": collectionId,
        "outlet_id": outletId,
        "shop_name": shopName,
        "payment_method": paymentMethod,
        "amount_paid": amountPaid,
        "payment_ref": paymentRef,
        "cheque_photo": chequePhoto,
        "record_time": recordTime?.toIso8601String(),
        "banked": banked?.toIso8601String(),
      };
}
