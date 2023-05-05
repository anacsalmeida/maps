import 'package:flutter/material.dart';
import 'package:learning_dart/models/model_login.dart';
import 'package:learning_dart/service/register_image.dart';
import 'package:learning_dart/service/register_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerLoginPage {
//variaveis
  VoidCallback? updateState;
  LoginModel? loginModel;

//controllers
  ScrollController scroll = new ScrollController();
  ServiceImage serviceImage = ServiceImage();
  ServiceUser serviceUser = ServiceUser();
  TextEditingController emailLogin = new TextEditingController();
  TextEditingController passwordLogin = new TextEditingController();

//actions
  Future<dynamic> userLogin(BuildContext context) async {
    loginModel = new LoginModel();
    Map usersLogin = {
      "email": emailLogin.text,
      "password": passwordLogin.text,
    };
    loginModel = LoginModel.fromJson(usersLogin);
    await serviceUser.registerLogin(loginModel!.toJson()).then((result) async {
      if (result != null) {
        print("Dados enviados.");
        Navigator.of(context).pushReplacementNamed('/fourth');
        final user = result['userLoged']['user'];
        String uid = user['uid'].toString();
        final token = user['stsTokenManager'];
        String accessToken = token['accessToken'].toString();
        String refreshToken = token['refreshToken'].toString();
        setAccessToken(accessToken);
        setRefreshToken(refreshToken);
        setUid(uid);
      } else {
        print("Usuário não encontrado.");
      }
    }).catchError((e) => print(e));
  }

  Future<String?> setAccessToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', value);
  }

  Future<String?> setRefreshToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('refreshToken', value);
  }

  Future<String?> setUid(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', value);
  }

  Future<bool> verifyTokenUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? chave = prefs.getString('accessToken');
    if (chave != null && chave.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> clearStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
