import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:solutech_sat/data/models/region.dart';
import 'package:solutech_sat/data/models/usertype.dart';
import 'package:solutech_sat/data/models/country.dart';

class UserLocation {
  @PrimaryKey(auto: false)
  int id;
  @Column(isNullable: true)
  int regionId;
  @Column(isNullable: true)
  String locationName;

  UserLocation({
    this.locationName,
    this.id,
    this.regionId,
  });

  factory UserLocation.fromMap(Map<String, dynamic> json) => UserLocation(
        locationName: json["location_name"],
        id: json["id"],
        regionId: json["region_id"],
      );

  Map<String, dynamic> toMap() => {
        "location_name": locationName,
        "id": id,
        "region_id": regionId,
      };
}
