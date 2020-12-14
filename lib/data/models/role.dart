import 'package:jaguar_orm/jaguar_orm.dart';

class Role {
  String key;

  @Column(isNullable: true)
  String status;
  Role({
    this.key,
    this.status,
  });

  Role.fromMap(Map<String, dynamic> json) {
    key = json['key'];
    status = json['status'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['status'] = this.status;
    return data;
  }
}
