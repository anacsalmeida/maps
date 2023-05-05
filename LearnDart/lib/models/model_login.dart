class LoginModel {
  String? emailLogin;
  String? passwordLogin;

  LoginModel({this.emailLogin, this.passwordLogin});
  LoginModel.fromJson(Map data) {
    this.emailLogin = data['email'];
    this.passwordLogin = data['password'];
  }
  Map toJson() {
    Map data = new Map();
    data['email'] = this.emailLogin;
    data['password'] = this.passwordLogin;
    return data;
  }
}
