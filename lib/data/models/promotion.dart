import 'package:jaguar_orm/jaguar_orm.dart';

class Promotion {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  String initiativeName;
  @Column(isNullable: true)
  String initiativeType;
  @Column(isNullable: true)
  int qualifyQuantity;
  @Column(isNullable: true)
  int freeQuantity;
  @Column(isNullable: true)
  DateTime startDate;
  @Column(isNullable: true)
  DateTime endDate;
  @Column(isNullable: true)
  String description;
  @Column(isNullable: true)
  String status;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;

  Promotion({
    this.id,
    this.initiativeName,
    this.initiativeType,
    this.qualifyQuantity,
    this.freeQuantity,
    this.startDate,
    this.endDate,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Promotion.fromMap(Map<String, dynamic> json) => Promotion(
        id: json["id"],
        initiativeName: json["initiative_name"],
        initiativeType: json["initiative_type"],
        qualifyQuantity: json["qualify_quantity"],
        freeQuantity: json["free_quantity"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        description: json["description"],
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
        "initiative_name": initiativeName,
        "initiative_type": initiativeType,
        "qualify_quantity": qualifyQuantity,
        "free_quantity": freeQuantity,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "description": description,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
