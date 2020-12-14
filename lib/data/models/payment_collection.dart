import 'package:jaguar_orm/jaguar_orm.dart';

class PaymentCollection {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  int shopId;
  @Column(isNullable: true)
  int salerId;
  @Column(isNullable: true)
  String appVersion;
  @Column(isNullable: true)
  String battery;
  @Column(isNullable: true)
  double paymentAmount;
  @Column(isNullable: true)
  String paymentMethod;
  @Column(isNullable: true)
  String paymentStatus;
  @Column(isNullable: true)
  String paymentId;
  @Column(isNullable: true)
  String paymentReference;
  @Column(isNullable: true)
  String notes;
  @Column(isNullable: true)
  String chequePhoto;
  @Column(isNullable: true)
  DateTime maturityDate;
  @Column(isNullable: true)
  DateTime nextPayment;
  @Column(isNullable: true)
  DateTime paymentTime;
  @Column(isNullable: true)
  double latitude;
  @Column(isNullable: true)
  double longitude;
  bool synced;
  bool fromServer;

  PaymentCollection({
    this.id,
    this.shopId,
    this.salerId,
    this.appVersion,
    this.battery,
    this.paymentAmount,
    this.paymentMethod,
    this.paymentStatus,
    this.paymentId,
    this.paymentReference,
    this.notes,
    this.chequePhoto,
    this.maturityDate,
    this.nextPayment,
    this.paymentTime,
    this.latitude,
    this.longitude,
    this.synced = false,
    this.fromServer = false,
  });

  factory PaymentCollection.fromMap(Map<String, dynamic> json) =>
      PaymentCollection(
        id: json["id"],
        shopId: json["shop_id"],
        salerId: json["saler_id"],
        appVersion: json["App_Version"],
        battery: json["Battery"],
        paymentAmount: json["payment_amount"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        paymentId: json["payment_id"],
        paymentReference: json["payment_reference"],
        notes: json["notes"],
        chequePhoto: json["cheque_photo"],
        maturityDate: json["maturity_date"] != null
            ? DateTime.parse(json["maturity_date"])
            : null,
        nextPayment: json["next_payment"] != null
            ? DateTime.parse(json["next_payment"])
            : null,
        paymentTime: json["payment_time"] != null
            ? DateTime.parse(json["payment_time"])
            : null,
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "shop_id": shopId,
        "saler_id": salerId,
        "App_Version": appVersion,
        "Battery": battery,
        "payment_amount": paymentAmount,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "payment_id": paymentId,
        "payment_reference": paymentReference,
        "notes": notes,
        "cheque_photo": chequePhoto,
        "maturity_date": maturityDate?.toIso8601String(),
        "next_payment": nextPayment?.toIso8601String(),
        "payment_time": paymentTime?.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
      };
}
