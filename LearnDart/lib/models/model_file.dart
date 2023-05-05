class FilesModel {
  String? base64;
  String? ext;
  String? name;
  String? mimetype;
  FilesModel({this.base64, this.ext, this.name, this.mimetype});
  FilesModel.fromJson(Map<String, dynamic> data) {
    base64 = data['base64'];
    ext = data['extension'];
    name = data['name'];
    mimetype = data['mimetype'];
  }

  Map sendToJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['extension'] = ext;
    data['name'] = name;
    data['mimetype'] = mimetype;
    data['base64'] = base64;
    return data;
  }
}
