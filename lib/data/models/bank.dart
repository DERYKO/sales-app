import 'package:jaguar_orm/jaguar_orm.dart';

class Bank {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  String bankName;
  @Column(isNullable: true)
  String bankCode;
  @Column(isNullable: true)
  int accountNumber;
  @Column(isNullable: true)
  String accountName;
  @Column(isNullable: true)
  String branchName;
  @Column(isNullable: true)
  String status;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;

  Bank({
    this.id,
    this.bankName,
    this.bankCode,
    this.accountNumber,
    this.accountName,
    this.branchName,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Bank.fromMap(Map<String, dynamic> json) => Bank(
        id: json["id"],
        bankName: json["bank_name"],
        bankCode: json["bank_code"],
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        branchName: json["branch_name"],
        status: json["status"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "bank_name": bankName,
        "bank_code": bankCode,
        "account_number": accountNumber,
        "account_name": accountName,
        "branch_name": branchName,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
