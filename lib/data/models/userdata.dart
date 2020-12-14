class Userdata {
  String name;
  String status;
  String phoneNumber;

  Userdata({
    this.name,
    this.status,
    this.phoneNumber,
  });

  factory Userdata.fromMap(Map<String, dynamic> json) => new Userdata(
        name: json["name"] == null ? null : json["name"],
        status: json["status"] == null ? null : json["status"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "status": status == null ? null : status,
        "phone_number": phoneNumber == null ? null : phoneNumber,
      };
}
