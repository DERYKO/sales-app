import 'package:jaguar_orm/jaguar_orm.dart';

class AppData {
  @PrimaryKey(auto: false)
  int appdataId;
  @Column(isNullable: true)
  String data;
  @Column(isNullable: true)
  String category;
  @Column(isNullable: true)
  String appdataTimestamp;

  AppData({this.appdataId, this.data, this.category, this.appdataTimestamp});

  AppData.fromMap(Map<String, dynamic> json) {
    appdataId = json['appdata_id'];
    data = json['data'];
    category = json['category'];
    appdataTimestamp = json['appdata_timestamp'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appdata_id'] = this.appdataId;
    data['data'] = this.data;
    data['category'] = this.category;
    data['appdata_timestamp'] = this.appdataTimestamp;
    return data;
  }
}
