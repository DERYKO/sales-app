class Region {
  int regionId;
  int countryId;
  String regionName;
  int dailyTarget;
  DateTime createdAt;
  DateTime updatedAt;

  Region({
    this.regionId,
    this.countryId,
    this.regionName,
    this.dailyTarget,
    this.createdAt,
    this.updatedAt,
  });

  factory Region.fromMap(Map<String, dynamic> json) => new Region(
        regionId: json["region_id"] == null ? null : json["region_id"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        regionName: json["region_name"] == null ? null : json["region_name"],
        dailyTarget: json["daily_target"] == null ? null : json["daily_target"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "region_id": regionId == null ? null : regionId,
        "country_id": countryId == null ? null : countryId,
        "region_name": regionName == null ? null : regionName,
        "daily_target": dailyTarget == null ? null : dailyTarget,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
