class Country {
  int countryId;
  String countryCode;
  String countryName;
  String language;
  int dialCode;
  String currencyName;
  String currencySymbol;
  String currencyCode;
  String countryStatus;
  DateTime createdAt;
  DateTime updatedAt;

  Country({
    this.countryId,
    this.countryCode,
    this.countryName,
    this.language,
    this.dialCode,
    this.currencyName,
    this.currencySymbol,
    this.currencyCode,
    this.countryStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory Country.fromMap(Map<String, dynamic> json) => new Country(
        countryId: json["country_id"] == null ? null : json["country_id"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        countryName: json["country_name"] == null ? null : json["country_name"],
        language: json["language"] == null ? null : json["language"],
        dialCode: json["dial_code"] == null ? null : json["dial_code"],
        currencyName:
            json["currency_name"] == null ? null : json["currency_name"],
        currencySymbol:
            json["currency_symbol"] == null ? null : json["currency_symbol"],
        currencyCode:
            json["currency_code"] == null ? null : json["currency_code"],
        countryStatus:
            json["country_status"] == null ? null : json["country_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "country_id": countryId == null ? null : countryId,
        "country_code": countryCode == null ? null : countryCode,
        "country_name": countryName == null ? null : countryName,
        "language": language == null ? null : language,
        "dial_code": dialCode == null ? null : dialCode,
        "currency_name": currencyName == null ? null : currencyName,
        "currency_symbol": currencySymbol == null ? null : currencySymbol,
        "currency_code": currencyCode == null ? null : currencyCode,
        "country_status": countryStatus == null ? null : countryStatus,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
