import 'package:jaguar_orm/jaguar_orm.dart';

class Banking {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  int userId;
  @Column(isNullable: true)
  String entryType;
  @Column(isNullable: true)
  int collectionId;
  @Column(isNullable: true)
  int customerId;
  @Column(isNullable: true)
  int bankId;
  @Column(isNullable: true)
  String amount;
  @Column(isNullable: true)
  String slipPhoto;
  @Column(isNullable: true)
  String bankName;
  @Column(isNullable: true)
  int accountNumber;
  @Column(isNullable: true)
  String branchName;
  @Column(isNullable: true)
  DateTime entryTime;
  @Column(isNullable: true)
  String latitude;
  @Column(isNullable: true)
  String longitude;
  @Column(isNullable: true)
  String notes;
  @Column(isNullable: true)
  bool synced;
  bool fromServer;
  Banking({
    this.id,
    this.userId,
    this.entryType,
    this.customerId,
    this.collectionId,
    this.bankId,
    this.amount,
    this.bankName,
    this.branchName,
    this.accountNumber,
    this.slipPhoto,
    this.entryTime,
    this.latitude,
    this.longitude,
    this.notes,
    this.synced = false,
    this.fromServer = false,
  });

  factory Banking.fromMap(Map<String, dynamic> json) => Banking(
        id: json["id"],
        userId: json["user_id"],
        entryType: json["entry_type"],
        customerId: json["customer_id"],
        collectionId: json["collection_id"],
        bankId: json["bank_id"],
        amount: json["amount"],
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        branchName: json["branch_name"],
        slipPhoto: json["slip_photo"],
        entryTime: json["entry_time"] != null
            ? DateTime.parse(json["entry_time"])
            : null,
        latitude: json["latitude"],
        longitude: json["longitude"],
        notes: json["notes"],
        synced: json["synced"],
        fromServer: json["from_server"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "entry_type": entryType,
        "customer_id": customerId,
        "collection_id": collectionId,
        "bank_id": bankId,
        "amount": amount,
        "bank_name": bankName,
        "account_number": accountNumber,
        "branch_name": branchName,
        "slip_photo": slipPhoto,
        "entry_time": entryTime?.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "notes": notes,
        "synced": synced,
        "from_server": fromServer
      };
}
