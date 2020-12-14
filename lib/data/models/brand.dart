import 'package:jaguar_orm/jaguar_orm.dart';

class Brand {
  @PrimaryKey()
  int id;
  @Column(isNullable: true)
  String category;
  @Column(isNullable: true)
  String brand;
  @Column(isNullable: true)
  int companyId;
  @Column(isNullable: true)
  String company;

  @Column(isNullable: true)
  String iscompetitor;

  Brand({
    this.id,
    this.category,
    this.brand,
    this.company,
    this.companyId,
    this.iscompetitor,
  });

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
        id: json["id"],
        category: json["category"],
        brand: json["brand"],
        company: json["company"],
        companyId: json["company_id"],
        iscompetitor: json["iscompetitor"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "company_id": companyId,
        "category": category,
        "brand": brand,
        "company": company,
        "iscompetitor": iscompetitor,
      };
}
