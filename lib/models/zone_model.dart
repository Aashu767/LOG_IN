// ignore_for_file: camel_case_types

class zonemodel1 {
  String? zoneId;
  String? zoneName;
  int? count;

  zonemodel1({this.zoneId, this.zoneName, this.count});

  zonemodel1.fromJson(Map<String, dynamic> json) {
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
