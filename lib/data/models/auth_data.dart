import 'package:solutech_sat/data/models/user.dart';

class AuthData {
  User user;
  String accessToken;

  AuthData({
    this.user,
    this.accessToken,
  });

  factory AuthData.fromMap(Map<String, dynamic> json) => new AuthData(
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        accessToken: json["accessToken"] == null ? null : json["accessToken"],
      );

  Map<String, dynamic> toMap() => {
        "user": user == null ? null : user.toMap(),
        "accessToken": accessToken == null ? null : accessToken,
      };
}
