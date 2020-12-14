import 'package:jaguar_orm/jaguar_orm.dart';

class Performance {
  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  String productDesc;
  @Column(isNullable: true)
  String target;
  @Column(isNullable: true)
  String achieved;
  @Column(isNullable: true)
  String perfomance;

  Performance({
    this.id,
    this.productDesc,
    this.target,
    this.achieved,
    this.perfomance,
  });

  factory Performance.fromMap(Map<String, dynamic> json) => Performance(
        id: json["id"],
        productDesc: "${json["product_desc"]}",
        target: json["target"] != null ? "${json["target"]}" : null,
        achieved: json["achieved"] != null ? "${json["achieved"]}" : null,
        perfomance: json["perfomance"] != null ? "${json["perfomance"]}" : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "product_desc": productDesc,
        "target": target,
        "achieved": achieved,
        "perfomance": perfomance,
      };
}
