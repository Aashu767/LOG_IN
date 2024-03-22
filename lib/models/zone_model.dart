// ignore_for_file: camel_case_types, unnecessary_new, unnecessary_this, prefer_collection_literals

class zonemodel {
  List<ComplaintsType>? complaintsType;

  zonemodel({this.complaintsType});

  zonemodel.fromJson(Map<String, dynamic> json) {
    if (json['Complaints_Type'] != null) {
      complaintsType = <ComplaintsType>[];
      json['Complaints_Type'].forEach((v) {
        complaintsType!.add(new ComplaintsType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.complaintsType != null) {
      data['Complaints_Type'] =
          this.complaintsType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ComplaintsType {
  String? zoneId;
  String? zoneName;
  int? count;

  ComplaintsType({this.zoneId, this.zoneName, this.count});

  ComplaintsType.fromJson(Map<String, dynamic> json) {
    zoneId = json['Zone_Id'];
    zoneName = json['Zone_Name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Zone_Id'] = this.zoneId;
    data['Zone_Name'] = this.zoneName;
    data['count'] = this.count;
    return data;
  }
}