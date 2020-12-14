import 'package:jaguar_orm/jaguar_orm.dart';

class Cheque {
  @PrimaryKey(auto: false)
  String outletId;
  @Column(isNullable: true)
  String amountPaid;
  @Column(isNullable: true)
  String paymentRef;
  @Column(isNullable: true)
  DateTime maturityDate;
  @Column(isNullable: true)
  String chequePhoto;
  @Column(isNullable: true)
  String nextPayment;
  @Column(isNullable: true)
  String notes;
  @Column(isNullable: true)
  int collectionId;
  @Column(isNullable: true)
  String latitude;
  @Column(isNullable: true)
  String longitude;

  Cheque({
    this.outletId,
    this.amountPaid,
    this.paymentRef,
    this.maturityDate,
    this.chequePhoto,
    this.nextPayment,
    this.notes,
    this.latitude,
    this.longitude,
    this.collectionId,
  });

  factory Cheque.fromMap(Map<String, dynamic> json) => Cheque(
      outletId: json["outlet_id"],
      amountPaid: json["amount_paid"],
      paymentRef: json["payment_ref"],
      maturityDate: json["maturity_date"] != null
          ? DateTime.parse(json["maturity_date"])
          : null,
      chequePhoto: json["cheque_photo"],
      nextPayment: json["next_payment"],
      notes: json["notes"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      collectionId: json["collection_id"]);

  Map<String, dynamic> toMap() => {
        "outlet_id": outletId,
        "amount_paid": amountPaid,
        "payment_ref": paymentRef,
        "maturity_date": maturityDate?.toIso8601String(),
        "cheque_photo": chequePhoto,
        "next_payment": nextPayment,
        "notes": notes,
        "latitude": latitude,
        "longitude": longitude,
        "collection_id": collectionId,
      };
}
