import 'package:jaguar_orm/jaguar_orm.dart';

class Order {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  double sellingTotalCost;
  @Column(isNullable: true)
  int salerId;
  @Column(isNullable: true)
  int shopId;
  @Column(isNullable: true)
  String visitId;
  @Column(isNullable: true)
  DateTime printedAt;
  @Column(isNullable: true)
  int newShop;
  @Column(isNullable: true)
  int orderId;
  @Column(isNullable: true)
  String creditNote;
  @Column(isNullable: true)
  String entryType;
  @Column(isNullable: true)
  String appVersion;
  @Column(isNullable: true)
  String lpoPhoto;
  @Column(isNullable: true)
  String lponumber;
  @Column(isNullable: true)
  String chequePhoto;
  @Column(isNullable: true)
  double paymentAmount;
  @Column(isNullable: true)
  String paymentReference;
  @Column(isNullable: true)
  String paymentMethod;
  @Column(isNullable: true)
  String paymentStatus;
  @Column(isNullable: true)
  double totalCost;
  @Column(isNullable: true)
  String callStatus;
  @Column(isNullable: true)
  String channel;
  @Column(isNullable: true)
  String orderType;
  @Column(isNullable: true)
  String battery;
  @Column(isNullable: true)
  String notes;
  @Column(isNullable: true)
  String paymentId;
  @Column(isNullable: true)
  DateTime maturityDate;
  @Column(isNullable: true)
  DateTime nextPayment;
  @Column(isNullable: true)
  DateTime expectedDelivery;
  @Column(isNullable: true)
  DateTime orderTime;
  @Column(isNullable: true)
  double latitude;
  @Column(isNullable: true)
  double longitude;
  @Column(isNullable: true)
  bool synced;
  @Column(isNullable: true)
  bool fromServer;

  Order({
    this.id,
    this.sellingTotalCost,
    this.salerId,
    this.shopId,
    this.visitId,
    this.newShop,
    this.orderId,
    this.entryType,
    this.appVersion,
    this.printedAt,
    this.lpoPhoto,
    this.lponumber,
    this.chequePhoto,
    this.paymentAmount,
    this.paymentReference,
    this.paymentMethod,
    this.paymentStatus,
    this.totalCost,
    this.creditNote,
    this.callStatus,
    this.expectedDelivery,
    this.channel,
    this.orderType,
    this.battery,
    this.paymentId,
    this.notes,
    this.maturityDate,
    this.nextPayment,
    this.orderTime,
    this.latitude,
    this.longitude,
    this.synced,
    this.fromServer,
  });

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"],
        sellingTotalCost: double.parse("${json["selling_total_cost"] ?? 0.0}"),
        salerId: json["saler_id"],
        visitId: json["visit_id"],
        shopId: json["shop_id"],
        newShop: json["new_shop"],
        orderId: json["order_id"],
        creditNote: json["credit_note"],
        entryType: json["entry_type"],
        printedAt: json["printed_at"] != null
            ? DateTime.parse(json["printed_at"])
            : null,
        appVersion: json["App_Version"],
        expectedDelivery: json["expected_delivery"] != null
            ? DateTime.parse(json["expected_delivery"])
            : null,
        lpoPhoto: json["lpo_photo"],
        lponumber: json["lponumber"],
        chequePhoto: json["cheque_photo"],
        paymentAmount: json["payment_amount"],
        paymentReference: json["payment_reference"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        notes: json["notes"],
        totalCost: double.parse("${json["total_cost"] ?? 0.0}"),
        callStatus: json["call_status"],
        channel: json["channel"],
        orderType: "${json["order_type"] ?? 0}",
        battery: json["Battery"],
        paymentId: json["payment_id"],
        maturityDate: json["maturity_date"] != null
            ? DateTime.parse(json["maturity_date"])
            : null,
        nextPayment: json["next_payment"] != null
            ? DateTime.parse(json["next_payment"])
            : null,
        orderTime: json["order_time"] != null
            ? DateTime.parse(json["order_time"])
            : null,
        latitude: double.parse("${json["latitude"] ?? 0.0}"),
        longitude: double.parse("${json["longitude"] ?? 0.0}"),
        synced: json["synced"],
        fromServer: json["from_server"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "selling_total_cost": sellingTotalCost,
        "saler_id": salerId,
        "visit_id": visitId,
        "shop_id": shopId,
        "credit_note": creditNote,
        "new_shop": newShop,
        "order_id": orderId,
        "entry_type": entryType,
        "printed_at": printedAt?.toIso8601String(),
        "App_Version": appVersion,
        "lpo_photo": lpoPhoto,
        "lponumber": lponumber,
        "cheque_photo": chequePhoto,
        "payment_amount": paymentAmount,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "payment_reference": paymentReference,
        "total_cost": totalCost,
        "expected_delivery": expectedDelivery?.toIso8601String(),
        "call_status": callStatus,
        "notes": notes,
        "channel": channel,
        "order_type": orderType,
        "Battery": battery,
        "payment_id": paymentId,
        "maturity_date": maturityDate?.toIso8601String(),
        "next_payment": nextPayment?.toIso8601String(),
        "order_time": orderTime?.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "synced": synced,
        "from_server": fromServer
      };
}
