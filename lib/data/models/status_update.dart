import 'package:jaguar_orm/jaguar_orm.dart';

class StatusUpdate {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  int salerId;
  @Column(isNullable: true)
  String statusCategory;
  @Column(isNullable: true)
  String statusNotes;
  @Column(isNullable: true)
  String statusType;
  @Column(isNullable: true)
  String statusPhoto;
  @Column(isNullable: true)
  DateTime statusTime;
  @Column(isNullable: true)
  DateTime startDate;
  @Column(isNullable: true)
  DateTime endDate;
  @Column(isNullable: true)
  String latitude;
  @Column(isNullable: true)
  String longitude;
  @Column(isNullable: true)
  String approver;
  @Column(isNullable: true)
  String approvalNotes;
  @Column(isNullable: true)
  DateTime approvalTime;
  @Column(isNullable: true)
  String status;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;
  @Column(isNullable: true)
  bool fromServer;
  bool synced;

  StatusUpdate({
    this.id,
    this.salerId,
    this.statusCategory,
    this.statusNotes,
    this.statusPhoto,
    this.statusType,
    this.statusTime,
    this.latitude,
    this.longitude,
    this.approver,
    this.approvalNotes,
    this.approvalTime,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.fromServer,
    this.synced,
  });

  factory StatusUpdate.fromMap(Map<String, dynamic> json) => StatusUpdate(
        id: json["id"],
        salerId: json["saler_id"],
        statusCategory: json["status_category"],
        statusNotes: json["status_notes"],
        statusPhoto: json["status_photo"],
        statusTime: json["status_time"] != null
            ? DateTime.parse(json["status_time"])
            : null,
        latitude: json["latitude"],
        longitude: json["longitude"],
        approver: json["approver"],
        approvalNotes: json["approval_notes"],
        approvalTime: json["approval_time"] != null
            ? DateTime.parse("${json["approval_time"]}")
            : null,
        statusType: json["status_type"],
        status: json["status"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        fromServer: json["from_server"],
        synced: json["synced"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "saler_id": salerId,
        "status_type": statusType,
        "status_category": statusCategory,
        "status_notes": statusNotes,
        "status_photo": statusPhoto,
        "start_date": startDate?.toIso8601String(),
        "end_date": startDate?.toIso8601String(),
        "status_time": statusTime?.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "approver": approver,
        "approval_notes": approvalNotes,
        "approval_time": approvalTime?.toIso8601String(),
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "from_server": fromServer,
        "synced": synced,
      };
}
