import 'package:solutech_sat/data/models/region.dart';
import 'package:solutech_sat/data/models/usertype.dart';
import 'package:solutech_sat/data/models/country.dart';

class User {
  int id;
  String userReference;
  int userType;
  int countryId;
  int regionId;
  int distributorId;
  int repCategory;
  int rolegroupId;
  String name;
  dynamic supervisorArea;
  String email;
  String password;
  String phoneNumber;
  int pricelistId;
  dynamic vehicleId;
  dynamic addedBy;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;
  Region region;
  Usertype usertype;
  Country country;

  User({
    this.id,
    this.userReference,
    this.userType,
    this.countryId,
    this.regionId,
    this.distributorId,
    this.repCategory,
    this.rolegroupId,
    this.name,
    this.supervisorArea,
    this.email,
    this.password,
    this.phoneNumber,
    this.pricelistId,
    this.vehicleId,
    this.addedBy,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.region,
    this.usertype,
    this.country,
  });

  factory User.fromMap(Map<String, dynamic> json) => new User(
        id: json["id"] == null ? null : json["id"],
        userReference:
            json["user_reference"] == null ? null : json["user_reference"],
        userType: json["user_type"] == null ? null : json["user_type"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        regionId: json["region_id"] == null ? null : json["region_id"],
        distributorId:
            json["distributor_id"] == null ? null : json["distributor_id"],
        repCategory: json["rep_category"] == null ? null : json["rep_category"],
        rolegroupId: json["rolegroup_id"] == null ? null : json["rolegroup_id"],
        name: json["name"] == null ? null : json["name"],
        supervisorArea: json["supervisor_area"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        pricelistId: json["pricelist_id"] == null ? null : json["pricelist_id"],
        vehicleId: json["vehicle_id"],
        addedBy: json["added_by"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        region: json["region"] == null ? null : Region.fromMap(json["region"]),
        usertype: json["usertype"] == null
            ? null
            : Usertype.fromMap(json["usertype"]),
        country:
            json["country"] == null ? null : Country.fromMap(json["country"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_reference": userReference == null ? null : userReference,
        "user_type": userType == null ? null : userType,
        "country_id": countryId == null ? null : countryId,
        "region_id": regionId == null ? null : regionId,
        "distributor_id": distributorId == null ? null : distributorId,
        "rep_category": repCategory == null ? null : repCategory,
        "rolegroup_id": rolegroupId == null ? null : rolegroupId,
        "name": name == null ? null : name,
        "supervisor_area": supervisorArea,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "pricelist_id": pricelistId == null ? null : pricelistId,
        "vehicle_id": vehicleId,
        "added_by": addedBy,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt == null ? null : deletedAt.toIso8601String(),
        "region": region == null ? null : region.toMap(),
        "usertype": usertype == null ? null : usertype.toMap(),
        "country": country == null ? null : country.toMap(),
      };
}
