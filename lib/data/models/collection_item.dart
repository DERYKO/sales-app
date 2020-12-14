import 'package:jaguar_orm/jaguar_orm.dart';

class CollectionItem {
  @Column(isNullable: true)
  int collectionId;
  @Column(isNullable: true)
  int invoiceId;
  @Column(isNullable: true)
  double amount;

  CollectionItem({
    this.collectionId,
    this.invoiceId,
    this.amount,
  });

  factory CollectionItem.fromMap(Map<String, dynamic> json) => CollectionItem(
        collectionId: json["collection_id"],
        invoiceId: json["invoice_id"],
        amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "collection_id": collectionId,
        "invoice_id": invoiceId,
        "amount": amount,
      };
}
