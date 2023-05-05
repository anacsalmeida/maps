class UserModel {
  String? displayName;
  String? userEmail;
  String? password;
  String? photoUrl;

  UserModel({this.displayName, this.userEmail, this.password, this.photoUrl});
  UserModel.fromJson(Map data) {
    this.displayName = data['displayName'];
    this.userEmail = data['email'];
    this.password = data['password'];
    this.photoUrl = data['photoUrl'];
  }
  Map toJson() {
    Map data = new Map();
    data['displayName'] = this.displayName;
    data['email'] = this.userEmail;
    data['password'] = this.password;
    data['photoUrl'] = this.photoUrl;
    return data;
  }
}
