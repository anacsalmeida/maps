import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_dart/models/model_file.dart';
import 'package:learning_dart/models/model_login.dart';
import 'package:learning_dart/models/model_user.dart';
import 'package:learning_dart/service/register_image.dart';
import 'package:learning_dart/service/register_user.dart';

class ControllerCadastroPage {
//variaveis
  XFile? file;
  VoidCallback? updateState;
  FilesModel? filesModel;
  UserModel? userModel;
  LoginModel? loginModel;
  List<UserModel> listUser = [];

//controllers
  ScrollController scroll = new ScrollController();
  ServiceImage serviceImage = ServiceImage();
  ServiceUser serviceUser = ServiceUser();
  TextEditingController displayName = new TextEditingController();
  TextEditingController userEmail = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmedPassword = new TextEditingController();

//actions
  Future<void> getImage(ImageSource source) async {
    XFile? filesReq = await ImagePicker.platform.getImage(source: source);
    if (filesReq != null) {
      file = filesReq;
      updateState!.call();
    }
  }

  Future<String> convertBase64() async {
    List<int> imageBytes = await file!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future<Map<String, dynamic>> dataImage() async {
    List<String> param = file!.path.split('/');
    List<String> paramSufix = param.last.toString().split('.');
    String name = paramSufix.first;
    String ext = '.' + paramSufix.last;
    String mimetype = 'image/' + paramSufix.last;
    filesModel = new FilesModel();
    Map<String, dynamic> data = {
      "base64": await convertBase64(),
      "extension": ext,
      "name": name,
      "mimetype": mimetype
    };
    return data;
  }

  Future<void> contextBody(BuildContext context) async {
    Map<String, dynamic> data = await dataImage();
    filesModel = FilesModel.fromJson(data);
    await serviceImage
        .registerImage(filesModel!.sendToJson())
        .then((value) async {
      print(value['docfile']);
      if (value != null) {
        userModel = new UserModel();
        Map users = {
          "displayName": displayName.text,
          "email": userEmail.text,
          "password": password.text,
          "photoUrl": value['docfile']
        };
        userModel = UserModel.fromJson(users);
        await serviceUser.registerUser(userModel!.toJson()).then((result) {
          if (result == true) {
            print("Dados enviados.");
          } else {
            print("Erro ao cadastrar usuário.");
          }
        }).catchError((e) => print(e));
      } else {
        print("Erro.");
      }
    }).catchError((e) => print(e));
  }

  clearRegister() {
    userEmail.clear();
    password.clear();
    confirmedPassword.clear();
    displayName.clear();
  }
}
