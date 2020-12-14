import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileManager {
  Future<bool> saveProfile(profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String profileString = json.encode(profile);
    prefs.setString("profile", profileString);
    return await prefs.commit();
  }

  Future<String> oldImageUrl() async {
    var profiles = await profileManager.getProfile();
    return profiles["imagepath"];
  }

  Future<String> imageUrl() async {
    var profiles = await profileManager.getProfile();
    return profiles["imagestorage"];
  }

  Future<Map> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String profileString = prefs.getString("profile");
    Map profile = json.decode(profileString);
    return profile;
  }

  Future<String> getGeofenceRadius() async {
    Map profile = await getProfile();
    String geofenceRadius = profile["geofenceradius"];
    return geofenceRadius;
  }
}

var profileManager = ProfileManager();
