class Usertype {
  int utypeId;
  String utypeName;
  String utypeDesc;
  String status;
  int salerType;

  Usertype({
    this.utypeId,
    this.utypeName,
    this.utypeDesc,
    this.status,
    this.salerType,
  });

  factory Usertype.fromMap(Map<String, dynamic> json) => new Usertype(
        utypeId: json["utype_id"] == null ? null : json["utype_id"],
        utypeName: json["utype_name"] == null ? null : json["utype_name"],
        utypeDesc: json["utype_desc"] == null ? null : json["utype_desc"],
        status: json["status"] == null ? null : json["status"],
        salerType: json["saler_type"] == null ? null : json["saler_type"],
      );

  Map<String, dynamic> toMap() => {
        "utype_id": utypeId == null ? null : utypeId,
        "utype_name": utypeName == null ? null : utypeName,
        "utype_desc": utypeDesc == null ? null : utypeDesc,
        "status": status == null ? null : status,
        "saler_type": salerType == null ? null : salerType,
      };
}
