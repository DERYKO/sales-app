import 'package:jaguar_orm/jaguar_orm.dart';

class StockTake {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  String visitid;
  @Column(isNullable: true)
  int salerId;
  @Column(isNullable: true)
  int outletId;
  @Column(isNullable: true)
  DateTime entryTime;
  @Column(isNullable: true)
  String stockphoto;
  @Column(isNullable: true)
  double latitude;
  @Column(isNullable: true)
  double longitude;
  @Column(isNullable: true)
  bool synced;
  @Column(isNullable: true)
  bool fromServer;

  StockTake({
    this.id,
    this.visitid,
    this.salerId,
    this.outletId,
    this.entryTime,
    this.stockphoto,
    this.latitude,
    this.longitude,
    this.synced = false,
    this.fromServer = false,
  });

  factory StockTake.fromMap(Map<String, dynamic> json) => StockTake(
      id: json["id"],
      visitid: json["visitid"],
      salerId: json["saler_id"],
      outletId: json["outlet_id"],
      entryTime: json["entry_time"] != null
          ? DateTime.parse(json["entry_time"])
          : null,
      stockphoto: json["stockphoto"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      synced: json["synced"],
      fromServer: json["from_server"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "visitid": visitid,
        "saler_id": salerId,
        "outlet_id": outletId,
        "entry_time": entryTime?.toIso8601String(),
        "stockphoto": stockphoto,
        "latitude": latitude,
        "longitude": longitude,
        "synced": synced,
        "from_server": fromServer,
      };
}
