import 'package:jaguar_orm/jaguar_orm.dart';

class PaymentMode {
  @PrimaryKey(auto: false)
  int id;
  @Column(isNullable: true)
  String paymentMode;
  @Column(isNullable: true)
  String slug;
  @Column(isNullable: true)
  String modeDescription;
  @Column(isNullable: true)
  String status;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;
  @Column(isNullable: true)
  DateTime deletedAt;

  PaymentMode({
    this.id,
    this.paymentMode,
    this.slug,
    this.modeDescription,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PaymentMode.fromMap(Map<String, dynamic> json) => PaymentMode(
        id: json["id"],
        paymentMode: json["payment_mode"],
        slug: json["slug"],
        modeDescription: json["mode_description"],
        status: json["status"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        deletedAt: json["deleted_at"] != null
            ? DateTime.parse(json["deleted_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "payment_mode": paymentMode,
        "slug": slug,
        "mode_description": modeDescription,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
      };
}
