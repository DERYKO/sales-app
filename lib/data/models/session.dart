import 'package:jaguar_orm/jaguar_orm.dart';

class Session {
  @PrimaryKey()
  String sessionId;
  @Column(
    isNullable: true,
  )
  int batteryLevel;
  @Column(
    isNullable: true,
  )
  String photo;
  @Column(
    isNullable: true,
  )
  int customerId;
  @Column(
    isNullable: true,
  )
  DateTime startTime;
  @Column(
    isNullable: true,
  )
  DateTime endTime;
  @Column(
    isNullable: true,
  )
  double latitude;
  @Column(
    isNullable: true,
  )
  double longitude;
  @Column(
    isNullable: true,
  )
  bool syncedStart;
  @Column(
    isNullable: true,
  )
  bool syncedEnd;
  @Column(
    isNullable: true,
  )
  bool fromServer;

  Session({
    this.customerId,
    this.startTime,
    this.batteryLevel,
    this.endTime,
    this.photo,
    this.sessionId,
    this.latitude,
    this.longitude,
    this.syncedStart,
    this.syncedEnd,
    this.fromServer = false,
  });

  factory Session.fromMap(Map<String, dynamic> json) => Session(
        customerId: json["customerId"],
        batteryLevel: json["battery_level"],
        photo: json["photo"],
        startTime: json["startTime"] != null
            ? DateTime.parse(json["startTime"])
            : null,
        endTime:
            json["endTime"] != null ? DateTime.parse(json["endTime"]) : null,
        sessionId: json["sessionId"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        syncedStart: json["synced_start"],
        syncedEnd: json["synced_end"],
      );

  Map<String, dynamic> toMap() => {
        "customerId": customerId,
        "battery_level": batteryLevel,
        "photo": photo,
        "startTime": startTime?.toIso8601String(),
        "endTime": startTime?.toIso8601String(),
        "sessionId": sessionId,
        "latitude": latitude,
        "longitude": longitude,
        "synced_start": syncedStart,
        "synced_end": syncedEnd,
      };
}
