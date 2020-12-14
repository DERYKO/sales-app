import 'package:jaguar_orm/jaguar_orm.dart';

class PrintedEtr {
  @PrimaryKey(auto: false)
  int orderId;

  @Column(isNullable: true)
  DateTime printedAt;
  @Column(isNullable: true)
  int printedBy;
  @Column(isNullable: true)
  bool synced;
  PrintedEtr({
    this.printedAt,
    this.orderId,
    this.printedBy,
    this.synced,
  });

  factory PrintedEtr.fromMap(Map<String, dynamic> json) => PrintedEtr(
        printedAt: DateTime.parse(json["printed_at"]),
        orderId: json["order_id"],
        printedBy: json["printed_by"],
        synced: json["synced"],
      );

  Map<String, dynamic> toMap() => {
        "printed_at": printedAt.toIso8601String(),
        "order_id": orderId,
        "printed_by": printedBy,
        "synced": synced,
      };
}
