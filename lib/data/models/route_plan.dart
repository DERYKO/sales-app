import 'package:jaguar_orm/jaguar_orm.dart';

class RoutePlan {
  @Column(
    isNullable: false,
  )
  int id;
  @Column(
    isNullable: true,
  )
  String name;
  @Column(
    isNullable: true,
  )
  String description;
  @Column(
    isNullable: true,
  )
  String visitDay;
  @Column(
    isNullable: true,
  )
  String visitWeek;
  @Column(
    isNullable: true,
  )
  String frequency;
  @Column(
    isNullable: true,
  )
  int shops;

  RoutePlan({
    this.id,
    this.name,
    this.description,
    this.visitDay,
    this.visitWeek,
    this.frequency,
    this.shops,
  });

  RoutePlan.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    visitDay = json['visitDay'];
    visitWeek = json['visitWeek'];
    frequency = json['frequency'];
    shops = json["shops"];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['visitDay'] = this.visitDay;
    data['visitWeek'] = this.visitWeek;
    data['frequency'] = this.frequency;
    data["shops"] = this.shops;
    return data;
  }
}
