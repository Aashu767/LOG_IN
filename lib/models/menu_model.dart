// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class MenuModel {
  int? menuId;
  String? menuName;
  int? count;

  MenuModel({this.menuId, this.menuName, this.count});

  MenuModel.fromJson(Map<String, dynamic> json) {
    menuId = json['Menu_Id'];
    menuName = json['Menu_Name'];
    count = json['Count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Menu_Id'] = this.menuId;
    data['Menu_Name'] = this.menuName;
    data['Count'] = this.count;
    return data;
  }
}