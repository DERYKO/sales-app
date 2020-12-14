import 'package:jaguar_orm/jaguar_orm.dart';

class ScheduledDelivery {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  DateTime scheduledTime;
  @Column(isNullable: true)
  DateTime dispatchTime;
  @Column(isNullable: true)
  String dispatchLat;
  @Column(isNullable: true)
  String dispatchLon;
  @Column(isNullable: true)
  DateTime returnTime;
  @Column(isNullable: true)
  String returnLat;
  @Column(isNullable: true)
  String returnLon;
  bool syncedStart;
  bool syncedEnd;
  bool fromServer;

  ScheduledDelivery({
    this.id,
    this.scheduledTime,
    this.dispatchTime,
    this.dispatchLat,
    this.dispatchLon,
    this.returnTime,
    this.returnLat,
    this.returnLon,
    this.syncedStart = false,
    this.syncedEnd = false,
    this.fromServer = false,
  });

  factory ScheduledDelivery.fromMap(Map<String, dynamic> json) =>
      ScheduledDelivery(
        id: json["id"],
        scheduledTime: json["scheduled_time"] != null
            ? DateTime.parse(json["scheduled_time"])
            : null,
        dispatchTime: json["dispatch_time"] != null
            ? DateTime.parse(json["dispatch_time"])
            : null,
        dispatchLat: json["dispatch_lat"],
        dispatchLon: json["dispatch_lon"],
        returnTime: json["return_time"] != null
            ? DateTime.parse(json["return_time"])
            : null,
        returnLat: json["return_lat"],
        returnLon: json["return_lon"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "scheduled_time": scheduledTime?.toIso8601String(),
        "dispatch_time": dispatchTime?.toIso8601String(),
        "dispatch_lat": dispatchLat,
        "dispatch_lon": dispatchLon,
        "return_time": returnTime?.toIso8601String(),
        "return_lat": returnLat,
        "return_lon": returnLon,
      };
}
