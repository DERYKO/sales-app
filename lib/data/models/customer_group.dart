import 'package:jaguar_orm/jaguar_orm.dart';

class CustomerGroup {
  @PrimaryKey(auto: false)
  int id;
  @Column(isNullable: true)
  String groupName;
  @Column(isNullable: true)
  int pricelistId;

  CustomerGroup({
    this.id,
    this.groupName,
    this.pricelistId,
  });

  factory CustomerGroup.fromMap(Map<String, dynamic> json) => CustomerGroup(
        id: json["id"],
        groupName: json["group_name"],
        pricelistId: json["pricelist_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "group_name": groupName,
        "pricelist_id": pricelistId,
      };
}
