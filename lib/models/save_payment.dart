// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals, camel_case_types

class save_data {
  String? schemeSKU;

  save_data({this.schemeSKU});

  save_data.fromJson(Map<String, dynamic> json) {
    schemeSKU = json['SchemeSKU'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SchemeSKU'] = this.schemeSKU;
    return data;
  }
}
