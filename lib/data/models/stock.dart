import 'package:jaguar_orm/jaguar_orm.dart';

class Stock {
  @PrimaryKey(auto: true)
  int id;
  String entryType;
  int supplierId;
  int salerId;
  @Column(isNullable: true)
  String comment;
  String totalCost;
  String paymentMethod;
  String reference;
  String entryTime;
  String latitude;
  String longitude;
  @Column(isNullable: true)
  String photo;
  bool synced;
  bool fromServer;

  Stock({
    this.id,
    this.entryType,
    this.supplierId,
    this.salerId,
    this.comment,
    this.paymentMethod,
    this.reference,
    this.totalCost,
    this.entryTime,
    this.latitude,
    this.longitude,
    this.photo,
    this.synced,
    this.fromServer,
  });

  factory Stock.fromMap(Map<String, dynamic> json) => new Stock(
        id: json["id"] == null ? null : json["id"],
        entryType: json["entry_type"] == null ? null : json["entry_type"],
        supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
        salerId: json["saler_id"] == null ? null : json["saler_id"],
        comment: json["comment"] == null ? null : json["comment"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        reference: json["reference"] == null ? null : json["reference"],
        totalCost: json["total_cost"] == null ? null : json["total_cost"],
        entryTime: json["entry_time"] == null ? null : json["entry_time"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        photo: json["photo"] == null ? null : json["photo"],
        synced: json["synced"] == null ? null : json["synced"],
        fromServer: json["from_server"] == null ? false : json["from_server"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "entry_type": entryType == null ? null : entryType,
        "supplier_id": supplierId == null ? null : supplierId,
        "saler_id": salerId == null ? null : salerId,
        "comment": comment == null ? null : comment,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "reference": reference == null ? null : reference,
        "entry_time": entryTime == null ? null : entryTime,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "photo": photo == null ? null : photo,
        "synced": synced == null ? null : synced,
        "from_server": fromServer == null ? false : fromServer,
      };
}
