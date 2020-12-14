import 'package:solutech_sat/data/models/userdata.dart';

class UpdateProfile {
  String geofenceradius;
  String appversion;
  String imagestorage;
  String forceupdate;
  Userdata userdata;

  UpdateProfile({
    this.geofenceradius,
    this.appversion,
    this.imagestorage,
    this.forceupdate,
    this.userdata,
  });

  factory UpdateProfile.fromMap(Map<String, dynamic> json) => new UpdateProfile(
        geofenceradius:
            json["geofenceradius"] == null ? null : json["geofenceradius"],
        appversion: json["appversion"] == null ? null : json["appversion"],
        imagestorage:
            json["imagestorage"] == null ? null : json["imagestorage"],
        forceupdate: json["forceupdate"] == null ? null : json["forceupdate"],
        userdata: json["userdata"] == null
            ? null
            : Userdata.fromMap(json["userdata"]),
      );

  Map<String, dynamic> toMap() => {
        "geofenceradius": geofenceradius == null ? null : geofenceradius,
        "appversion": appversion == null ? null : appversion,
        "imagestorage": imagestorage == null ? null : imagestorage,
        "forceupdate": forceupdate == null ? null : forceupdate,
        "userdata": userdata == null ? null : userdata.toMap(),
      };
}
