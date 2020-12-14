import 'package:jaguar_orm/jaguar_orm.dart';

class FeedbackCategory {
  @PrimaryKey(auto: false)
  int id;
  @Column(isNullable: true)
  String categoryname;
  @Column(isNullable: true)
  String feedbackCategory;
  @Column(isNullable: true)
  String hasbatch;
  @Column(isNullable: true)
  String status;
  @Column(isNullable: true)
  DateTime createdAt;
  @Column(isNullable: true)
  DateTime updatedAt;
  @Column(isNullable: true)
  DateTime deletedAt;

  FeedbackCategory({
    this.id,
    this.categoryname,
    this.feedbackCategory,
    this.hasbatch,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory FeedbackCategory.fromMap(Map<String, dynamic> json) =>
      FeedbackCategory(
        id: json["id"],
        categoryname: json["categoryname"],
        feedbackCategory: json["feedback_category"],
        hasbatch: json["hasbatch"],
        status: json["status"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        deletedAt: json["deleted_at"] != null
            ? DateTime.parse(json["deleted_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "categoryname": categoryname,
        "feedback_category": feedbackCategory,
        "hasbatch": hasbatch,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
      };
}
