// ignore_for_file: unnecessary_this, camel_case_types, prefer_collection_literals

class subordinate_model {
  List<UserList>? userList;

  subordinate_model({this.userList});

  subordinate_model.fromJson(Map<String, dynamic> json) {
    if (json['UserList'] != null) {
      userList = <UserList>[];
      json['UserList'].forEach((v) {
        userList!.add(UserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.userList != null) {
      data['UserList'] = this.userList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserList {
  String? eMPLID;
  String? eMPLNAME;

  UserList({this.eMPLID, this.eMPLNAME});

  UserList.fromJson(Map<String, dynamic> json) {
    eMPLID = json['EMPL_ID'];
    eMPLNAME = json['EMPL_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['EMPL_ID'] = this.eMPLID;
    data['EMPL_NAME'] = this.eMPLNAME;
    return data;
  }
}