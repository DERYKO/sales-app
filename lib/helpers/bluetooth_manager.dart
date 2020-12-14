import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial_caravanas/flutter_bluetooth_serial.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/device_utils.dart';

class BluetoothManager extends Manager {
  static BluetoothManager instance;
  factory BluetoothManager() => instance ??= BluetoothManager._instance();
  BluetoothManager._instance();
  MethodChannel _bluetoothChannel =
      const MethodChannel('sat.solutech.com/bluetooth');

  StreamSubscription<ConnectivityResult> _subscription;
  bool _available = false;
  bool _isEnabled = false;
  bool _isConnecting = false;
  BluetoothDevice bluetoothDevice;
  bool get isEnabled => _isEnabled;
  bool get connectedToDevice => bluetoothDevice != null;
  bool get isAvailable => _available;
  bool get isConnecting => _isConnecting;
  List<BluetoothDevice> scannedDevices = [];

  set isEnabled(bool on) {
    this._isEnabled = on;
    notifyChanges();
  }

  set isConnecting(bool scanning) {
    this._isConnecting = scanning;
    notifyChanges();
  }

  set isAvailable(bool available) {
    this._available = available;
    notifyChanges();
  }

  Future _setOnStatus() async {
    isAvailable = await bluetooth.isAvailable;
    isEnabled = isAvailable && await bluetooth.isEnabled;
    scanDevices();
  }

  void _setConnectivityStream() {
    bluetooth.onStateChanged().listen((BluetoothState state) {
      if (state == BluetoothState.STATE_ON) {
        _setOnStatus();
      } else if (state == BluetoothState.STATE_OFF) {
        _setOnStatus();
      }
    });
  }

  void scanDevices() async {
    if (isEnabled) {
      print("Started scanning...");
      scannedDevices = await bluetooth.getBondedDevices();
    } else {
      bluetoothDevice = null;
      notifyChanges();
    }
  }

  Future connectToDevice(BluetoothDevice device) async {
    //BluetoothConnection.toAddress(device.address){}
    isConnecting = true;
    var nativeConnected = await onBluetoothConnect("${device.address}");

    if (nativeConnected) {
      print("NATIVE_CONNECTED");
      bluetoothDevice = device;
      isConnecting = false;
    } else {
      print("NATIVE_DISCONNECTED");
      bluetoothDevice = null;
      isConnecting = false;
    }
  }

  Future<bool> onBluetoothConnect(String address) {
    return _bluetoothChannel
        .invokeMethod('onBluetoothConnect', <String, String>{
      "address": address,
    });
  }

  void enableBluetooth() async {
    if (isAvailable) {
      await bluetooth.requestEnable();
      _setOnStatus();
    }
  }

  @override
  Future init() async {
    super.init();
    await _setOnStatus();
    _setConnectivityStream();
  }

  @override
  void destroy() {
    super.destroy();
    _subscription?.cancel();
  }
}

var bluetoothManager = BluetoothManager();
