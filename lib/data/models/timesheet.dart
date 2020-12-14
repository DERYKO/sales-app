import 'package:jaguar_orm/jaguar_orm.dart';

class Timesheet {
  @PrimaryKey(auto: true)
  int timesheetId;
  @Column(isNullable: true)
  String visitid;
  @Column(isNullable: true)
  int branchId;
  @Column(isNullable: true)
  String checkinLatitude;
  @Column(isNullable: true)
  String checkinLongitude;
  @Column(isNullable: true)
  String checkinAddress;
  @Column(isNullable: true)
  String checkinPhoto;
  @Column(isNullable: true)
  String checkoutLatitude;
  @Column(isNullable: true)
  String checkoutLongitude;
  @Column(isNullable: true)
  String checkoutAddress;
  @Column(isNullable: true)
  DateTime checkinTime;
  @Column(isNullable: true)
  DateTime checkoutStime;
  @Column(isNullable: true)
  DateTime checkoutTime;
  @Column(isNullable: true)
  int merchandiserId;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;

  Timesheet({
    this.timesheetId,
    this.visitid,
    this.branchId,
    this.checkinLatitude,
    this.checkinLongitude,
    this.checkinAddress,
    this.checkinPhoto,
    this.checkoutLatitude,
    this.checkoutLongitude,
    this.checkoutAddress,
    this.checkinTime,
    this.checkoutStime,
    this.checkoutTime,
    this.merchandiserId,
    this.createdAt,
    this.updatedAt,
  });

  factory Timesheet.fromMap(Map<String, dynamic> json) => Timesheet(
        timesheetId: json["timesheet_id"],
        visitid: json["visitid"],
        branchId: json["branch_id"],
        checkinLatitude: json["checkin_latitude"],
        checkinLongitude: json["checkin_longitude"],
        checkinAddress: json["checkin_address"],
        checkinPhoto: json["checkin_photo"],
        checkoutLatitude: json["checkout_latitude"],
        checkoutLongitude: json["checkout_longitude"],
        checkoutAddress: json["checkout_address"],
        checkinTime: json["checkin_time"] != null
            ? DateTime.parse(json["checkin_time"])
            : null,
        checkoutStime: json["checkout_stime"] != null
            ? DateTime.parse(json["checkout_stime"])
            : null,
        checkoutTime: json["checkout_time"] != null
            ? DateTime.parse(json["checkout_time"])
            : null,
        merchandiserId: json["merchandiser_id"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "timesheet_id": timesheetId,
        "visitid": visitid,
        "branch_id": branchId,
        "checkin_latitude": checkinLatitude,
        "checkin_longitude": checkinLongitude,
        "checkin_address": checkinAddress,
        "checkin_photo": checkinPhoto,
        "checkout_latitude": checkoutLatitude,
        "checkout_longitude": checkoutLongitude,
        "checkout_address": checkoutAddress,
        "checkin_time": checkinTime.toIso8601String(),
        "checkout_stime": checkoutStime.toIso8601String(),
        "checkout_time": checkoutTime.toIso8601String(),
        "merchandiser_id": merchandiserId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
