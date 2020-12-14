import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/auth_data.dart';
import 'package:solutech_sat/data/models/user.dart';

class AuthManager {
  SharedPreferences _prefs;
  User get user {
    String _user = _prefs?.getString("user") ?? null;
    if (_user == null) return null;
    return User.fromMap(json.decode(_user));
  }

  String get accessToken => _prefs?.getString("accessToken");

  bool get isLoggedIn {
    return (user != null && accessToken != null) ? true : false;
  }

  AuthData get authData {
    return AuthData(
      user: user,
      accessToken: accessToken,
    );
  }

  Future<bool> setUser(User user) async {
    return await _prefs?.setString("user", json.encode(user.toMap()));
  }

  Future<bool> setAccessToken(String token) async {
    return await _prefs?.setString("accessToken", token);
  }

  Future<bool> setAuthData(AuthData authData) async {
    print("AuthData ${authData.toMap()}");
    return (await setAccessToken(authData.accessToken) &&
        await setUser(authData.user));
  }

  Future<bool> logout() async {
    db.clearData();
    return (await _prefs.remove("user") && await _prefs.remove("accessToken"));
  }

  Future login({
    String email,
    String password,
  }) async {
    return api
        .login(email, password)
        .then(_onLoginResponse)
        .catchError(_onLoginError);
  }

  _onLoginResponse(response) async {
    if (response.data["status"] != 1) {
      throw DioError(response: response);
    }
    var payload = response.data["payload"];
    await authManager.setAuthData(AuthData.fromMap(payload));
    return response;
  }

  _onLoginError(error) async {
    return throw error;
  }

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}

var authManager = AuthManager();
