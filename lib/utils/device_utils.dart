import 'dart:io';

import 'package:battery/battery.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_bluetooth_serial_caravanas/flutter_bluetooth_serial.dart';

var battery = Battery();
FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

Future<String> deviceDetails() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String device = "";
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    device =
        "${androidInfo.brand} ${androidInfo.model} Android ${androidInfo.version.release}";
    print("Running on ");
  } else {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    device =
        "${iosInfo.name} ${iosInfo.utsname.machine} IOS ${iosInfo.utsname.version}";
  }
  return device;
}
