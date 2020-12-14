import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/refresh_screen.dart';
import 'package:solutech_sat/ui/screen/setup_screen.dart';

class LoginBloc extends Bloc {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  bool obscurePassword = true;
  bool loading = false;

  setLoading(bool state) {
    this.loading = state;
    notifyChanges();
  }

  void changePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyChanges();
  }

  bool validFields() {
    return (loginFormKey.currentState.validate());
  }

  void login() async {
    if (validFields()) {
      setLoading(true);
      authManager
          .login(
            email: emailCtrl.text,
            password: passwordCtrl.text,
          )
          .then(onLoginSuccess)
          .catchError(onLoginError);
    }
  }

  void setupClient() {
    config.setVariant("DEMO");
    popAndNavigate(screen: SetupScreen());
  }

  void onLoginSuccess(response) {
    setLoading(false);
    navigateToRefreshScreen();
  }

  void onLoginError(error) {
    setLoading(false);
    if (error is DioError) {
      if (error.type == DioErrorType.DEFAULT) {
        if (error.response?.data is Map) {
          alert("Unsuccessful", "${error.response.data["message"]}");
        } else {
          alert("Unsuccessful", "Something went wrong");
          print("${error.message}");
        }
      }

      if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        alert("Unsuccessful", "Request time out");
      }

      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        alert("Unsuccessful", "Connection time out");
      }

      if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        alert("Unsuccessful", "Response time out");
      }

      if (error.type == DioErrorType.CANCEL) {
        alert("Unsuccessful", "Connection time out");
      }
    }
  }

  void navigateToRefreshScreen() async {
    popAndNavigate(screen: RefreshScreen());
  }

  @override
  void initState() {
    super.initState();
  }
}
