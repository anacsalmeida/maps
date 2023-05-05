import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:learning_dart/core/custom_http.dart';
import 'package:learning_dart/utils/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceUser {
  CustomHttp _http = new CustomHttp();
  Future<bool> registerUser(Map body) async {
    bool result = false;
    try {
      Response response = await _http.client
          .post(Endpoint.registerUser, data: json.encode(body));
      result = true;
      return result;
    } on DioError catch (e) {
      print(e.error);
      print(e.response!.statusCode);
      print(e.response!.data);
      return result;
    }
  }

  Future<dynamic> registerLogin(Map body) async {
    try {
      Response response = await _http.client
          .post(Endpoint.registerLogin, data: json.encode(body));
      return response.data['DATA'];
    } on DioError catch (e) {
      print(e.error);
      print(e.response!.statusCode);
      print(e.response!.data);
      return null;
    }
  }

  Future<dynamic> user() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? uid = prefs.getString('uid');
      print("Service uid = $uid");
      Response response = await _http.client.get(Endpoint.userId + uid!);
      return response.data;
    } on DioError catch (e) {
      print(e.error);
      print(e.response!.statusCode);
      print(e.response!.data);
      return null;
    }
  }
}
