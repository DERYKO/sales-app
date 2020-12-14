import 'package:jaguar_orm/jaguar_orm.dart';

class Feedback {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  int feedId;
  @Column(isNullable: true)
  String category;
  @Column(isNullable: true)
  int repId;
  @Column(isNullable: true)
  int assignedid;
  @Column(isNullable: true)
  String visitId;
  @Column(isNullable: true)
  int productId;
  @Column(isNullable: true)
  String brand;
  @Column(isNullable: true)
  int quantity;
  @Column(isNullable: true)
  String batchnumber;
  @Column(isNullable: true)
  String notes;
  @Column(isNullable: true)
  String photo;
  @Column(isNullable: true)
  String priorityLevel;
  @Column(isNullable: true)
  int outletId;
  @Column(isNullable: true)
  String lat;
  @Column(isNullable: true)
  String lon;
  @Column(isNullable: true)
  DateTime entryTime;
  @Column(isNullable: true)
  int assignedTo;
  @Column(isNullable: true)
  String status;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;
  @Column(isNullable: true)
  bool synced;
  @Column(isNullable: true)
  bool fromServer;

  Feedback({
    this.id,
    this.feedId,
    this.category,
    this.repId,
    this.productId,
    this.brand,
    this.quantity,
    this.batchnumber,
    this.assignedid,
    this.notes,
    this.photo,
    this.priorityLevel,
    this.outletId,
    this.visitId,
    this.lat,
    this.lon,
    this.entryTime,
    this.assignedTo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.synced,
    this.fromServer,
  });

  factory Feedback.fromMap(Map<String, dynamic> json) => Feedback(
        assignedid: json["assignedid"],
        id: json["id"],
        feedId: json["id"],
        visitId: json["visit_id"],
        category: json["category"],
        repId: json["rep_id"],
        productId: json["product_id"],
        brand: json["brand"],
        quantity: json["quantity"],
        batchnumber: json["batchnumber"],
        notes: json["notes"],
        photo: json["photo"],
        priorityLevel: json["priority_level"],
        outletId: json["outlet_id"],
        lat: json["lat"],
        lon: json["lon"],
        entryTime: json["entry_time"] != null
            ? DateTime.parse(json["entry_time"])
            : null,
        assignedTo: json["assigned_to"],
        status: json["status"],
        createdAt: (json["created_at"] != null)
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : null,
        synced: json["synced"],
        fromServer: json["from_server"],
      );

  Map<String, dynamic> toMap() => {
        "assignedid": assignedid,
        "id": id,
        "feed_id": feedId,
        "category": category,
        "rep_id": repId,
        "product_id": productId,
        "brand": brand,
        "quantity": quantity,
        "batchnumber": batchnumber,
        "notes": notes,
        "photo": photo,
        "priority_level": priorityLevel,
        "outlet_id": outletId,
        "visit_id": visitId,
        "lat": lat,
        "lon": lon,
        "entry_time": entryTime?.toIso8601String(),
        "assigned_to": assignedTo,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "synced": synced,
        "from_server": fromServer
      };
}
