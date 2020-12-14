import 'package:jaguar_orm/jaguar_orm.dart';

class PaymentDocument {
  @PrimaryKey(auto: false)
  int id;
  @Column(isNullable: true)
  int collectionId;
  @Column(isNullable: true)
  int invoiceId;
  @Column(isNullable: true)
  String amount;
  @Column(isNullable: true)
  String postFlag;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;

  PaymentDocument({
    this.id,
    this.collectionId,
    this.invoiceId,
    this.amount,
    this.postFlag,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentDocument.fromMap(Map<String, dynamic> json) => PaymentDocument(
        id: json["id"],
        collectionId: json["collection_id"],
        invoiceId: json["invoice_id"],
        amount: json["amount"],
        postFlag: json["POST_FLAG"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collection_id": collectionId,
        "invoice_id": invoiceId,
        "amount": amount,
        "POST_FLAG": postFlag,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
