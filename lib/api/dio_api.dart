import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';

class DioApi {
  Dio dio;
  var currentLocation = {"latitude": 0.0, "longitude": 0.0};
  var location = new Location();

  DioApi(String apiUrl) {
    dio = Dio();
    dio.options.baseUrl = apiUrl;
    dio.interceptors.add(InterceptorsWrapper(onRequest: _requestIntercept));
    dio.interceptors.add(InterceptorsWrapper(onResponse: _responseIntercept));
    dio.interceptors.add(InterceptorsWrapper(onError: _errorIntercept));
  }

  _requestIntercept(RequestOptions options) async {
    if (await authManager.isLoggedIn) {
      String token = authManager.accessToken;
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    print("Authorization ${authManager.accessToken}");
    print("Is Logged in ${authManager.isLoggedIn}");
    print(
        "${options.method}: ${options.baseUrl}${options.path} ${options.queryParameters}");
    print("BODY: ${json.encode(options.data)}");
    return options;
  }

  _responseIntercept(Response response) async {
    print("${response.request?.path} ${response.data}");
    return response;
  }

  _errorIntercept(DioError error) async {
    print("${error.request?.path} ${error.response?.data}");
    return error;
  }
}
