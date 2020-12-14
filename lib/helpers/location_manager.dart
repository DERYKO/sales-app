import 'dart:async';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' show Location;
import 'package:permission_handler/permission_handler.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/device_utils.dart';

class LocationManager extends Manager {
  var location = new Location();
  var geolocator = Geolocator();
  bool _serviceEnabled = true;

  LocationManager() {
    geolocator.isLocationServiceEnabled().asStream().listen((enabled) {
      serviceEnabled = enabled;
      notifyChanges();
    });
  }

  Position position;
  StreamSubscription<Position> positionStream;
  var locationOptions = LocationOptions(
    accuracy: LocationAccuracy.bestForNavigation,
    distanceFilter: 5,
  );

  set serviceEnabled(bool enabled) {
    _serviceEnabled = enabled;
    notifyChanges();
  }

  bool get serviceEnabled => _serviceEnabled;

  List<UserLocation> userLocations = [];

  Future getDBData() async {
    userLocations = await db.userLocationBean.getAll();
    notifyChanges();
  }

  Future init() async {
    await checkService();
    await getDBData();
  }

  UserLocation getUserLocationById(int id) {
    return userLocations.firstWhere((userLocation) => userLocation.id == id,
        orElse: () => null);
  }

  void enableLocationService() async {
    serviceEnabled = await location.requestService();
    notifyChanges();
  }

  void startLocationStream() {
    positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) async {
      if (!await location.serviceEnabled()) {
        serviceEnabled = false;
        notifyChanges();
      } else {
        serviceEnabled = true;
        notifyChanges();
      }
      if (position != null) {
        this.position = position;
        notifyChanges();
      }
      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());
    });
  }

  Future<Position> currentLocation() async {
    if (!await location.serviceEnabled()) {
      serviceEnabled = false;
      notifyChanges();
    } else {
      serviceEnabled = true;
      notifyChanges();
    }
    return await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
  }

  get distanceBetween => geolocator.distanceBetween;

  void checkPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (permission == PermissionStatus.denied ||
        permission == PermissionStatus.unknown) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.location]);
      if (permissions[PermissionGroup.location] == PermissionStatus.denied) {
        checkPermission();
      }
    } else {
      startLocationStream();
    }
  }

  Future loadUserLocations() {
    showLoader(true);
    return api.getUserLocations().then((response) async {
      if (response.data["status"] == 1 || response.data["status"] == 0) {
        var payload = response.data["payload"];
        await _saveLocationsLocally(payload);
        showLoader(false);
        return response;
      } else {
        showLoader(false);
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future sendLiveLocation() async {
    String device = "${await deviceDetails()}";
    print('Running on $device');
    showLoader(true);
    return api.sendLiveLocation({
      'latitude': locationManager.position.latitude,
      'longitude': locationManager.position.longitude,
      'user_id': authManager.user.id,
      'app_version': config.appVersion,
      'device_info': device,
      'battery_level': await battery.batteryLevel,
      'entry_time': DateTime.now().toIso8601String(),
      'accuracy_level': locationManager.position.accuracy,
    }).then((response) async {
      if (response.data["status"] == 1) {
        showLoader(false);
        return response;
      } else {
        showLoader(false);
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _saveLocationsLocally(payload) async {
    await db.userLocationBean.removeAll();
    for (var item in payload) {
      await db.userLocationBean.insert(UserLocation.fromMap(item));
    }
    print("User locations saved");
    await getDBData();
  }

  Future checkService() async {
    ServiceStatus serviceStatus =
        await PermissionHandler().checkServiceStatus(PermissionGroup.location);
    if (serviceStatus == ServiceStatus.disabled) {
      var enabled = await location.requestService();
    }
    checkPermission();
  }

  Future<double> distanceInMeters(lat, lon) async {
    return await Geolocator().distanceBetween(
      double.parse("${lat ?? 0}"),
      double.parse("${lon ?? 0}"),
      position.latitude,
      position.longitude,
    );
  }

  Future<String> calculateDistance(double lat, double lon) async {
    if (position.latitude == null) {
      position = await geolocator.getCurrentPosition();
      notifyChanges();
    }
    print(
        "lat: $lat, lon: $lon; lat:${position.latitude},lon: ${position.longitude}");
    double meters = await distanceInMeters(lat, lon);
    var distance =
        "${meters > 1000 ? (meters / 1000).toStringAsFixed(1) + " Km" : meters.toStringAsFixed(1) + " M"}";
    return distance;
  }

  void destroy() {
    positionStream?.cancel();
  }
}

var locationManager = LocationManager();
