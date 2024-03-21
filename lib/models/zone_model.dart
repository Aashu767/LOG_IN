class ZoneModel {
  List<ComplaintsType>? complaintsType;

  ZoneModel({this.complaintsType});

  ZoneModel.fromJson(Map<String, dynamic> json) {
    if (json['Complaints_Type'] != null) {
      complaintsType = <ComplaintsType>[];
      json['Complaints_Type'].forEach((v) {
        complaintsType!.add(ComplaintsType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (complaintsType != null) {
      data['Complaints_Type'] =
          complaintsType!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Zone_Id'] = zoneId;
    data['Zone_Name'] = zoneName;
    data['count'] = count;
    return data;
  }
}
