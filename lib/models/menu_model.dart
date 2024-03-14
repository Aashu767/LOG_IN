// ignore_for_file: prefer_collection_literals

class MenuModel {
  List<MenuDetails>? menuDetails;

  MenuModel({this.menuDetails});

  MenuModel.fromJson(Map<String, dynamic> json) {
    if (json['Menu_Details'] != null) {
      menuDetails = <MenuDetails>[];
      json['Menu_Details'].forEach((v) {
        menuDetails!.add(MenuDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (menuDetails != null) {
      data['Menu_Details'] = menuDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuDetails {
  int? menuId;
  String? menuName;
  int? count;

  MenuDetails({this.menuId, this.menuName, this.count});

  MenuDetails.fromJson(Map<String, dynamic> json) {
    menuId = json['Menu_Id'];
    menuName = json['Menu_Name'];
    count = json['Count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Menu_Id'] = menuId;
    data['Menu_Name'] = menuName;
    data['Count'] = count;
    return data;
  }
}
