import 'package:jaguar_orm/jaguar_orm.dart';

class MpesaPayment {
  int id;
  int storeNumber;
  String transactionreference;
  String accountReference;
  DateTime transactionTime;
  String customerphone;
  String customername;
  String amount;
  String status;
  int used;
  DateTime createdAt;
  DateTime updatedAt;

  MpesaPayment({
    this.id,
    this.storeNumber,
    this.transactionreference,
    this.accountReference,
    this.transactionTime,
    this.customerphone,
    this.customername,
    this.amount,
    this.status,
    this.used,
    this.createdAt,
    this.updatedAt,
  });

  factory MpesaPayment.fromMap(Map<String, dynamic> json) => MpesaPayment(
        id: json["id"],
        storeNumber: json["storeNumber"],
        transactionreference: json["transactionreference"],
        accountReference: json["account_reference"],
        transactionTime: json["transaction_time"] != null
            ? DateTime.parse(json["transaction_time"])
            : null,
        customerphone: json["customerphone"],
        customername: json["customername"],
        amount: json["amount"],
        status: json["status"],
        used: json["used"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "storeNumber": storeNumber,
        "transactionreference": transactionreference,
        "account_reference": accountReference,
        "transaction_time": transactionTime?.toIso8601String(),
        "customerphone": customerphone,
        "customername": customername,
        "amount": amount,
        "status": status,
        "used": used,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
