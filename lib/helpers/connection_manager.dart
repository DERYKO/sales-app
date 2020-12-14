import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class ConnectionManager extends Manager {
  static ConnectionManager instance;
  factory ConnectionManager() => instance ??= ConnectionManager._instance();
  ConnectionManager._instance();

  StreamSubscription<ConnectivityResult> _subscription;
  ConnectivityResult _result;
  DataConnectionChecker _connectionChecker = DataConnectionChecker();
  bool _isDeviceOnline = false;
  bool get isConnected => _result != ConnectivityResult.none;
  bool get isWifi => _result == ConnectivityResult.wifi;
  bool get isMobile => _result == ConnectivityResult.mobile;
  bool get isOnline =>
      (_result != null && _result != ConnectivityResult.none) &&
      _isDeviceOnline;

  void setServerIp(String ip) {
    _connectionChecker.addresses = List.unmodifiable([
      AddressCheckOptions(
        InternetAddress("$ip"),
        port: 53,
        timeout: Duration(seconds: 10),
      )
    ]);
  }

  Future _setConnectionStatus() async {
    _result = await Connectivity().checkConnectivity();
    if (_result != ConnectivityResult.none) {
      _isDeviceOnline = true;
    }
  }

  @override
  Future init() async {
    super.init();
    await _setConnectionStatus();
    setServerIp(config.serverIp);
    _setConnectionStream();
    _setOnlineStream();
  }

  void _setConnectionStream() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      print("Conn_Ectivity changed $result");
      this._result = result;
      syncManager.sync();
      _checkOnlineStatus();
      notifyChanges();
    });
  }

  void _setOnlineStream() {
    print("Checking online status: Stream");
    _connectionChecker.onStatusChange.listen((DataConnectionStatus status) {
      print("Connectivity changed : $status");
      if (status == DataConnectionStatus.connected) {
        _isDeviceOnline = true;
        notifyChanges();
      } else {
        _isDeviceOnline = false;
        notifyChanges();
      }
    });
  }

  void _checkOnlineStatus() {
    print("Checking online status");
    _connectionChecker.hasConnection.then((status) {
      _isDeviceOnline = status;
      print("Checked online status: $status");

      notifyChanges();
    });
  }

  @override
  void destroy() {
    super.destroy();
    _subscription?.cancel();
  }
}

var connectionManager = ConnectionManager();
