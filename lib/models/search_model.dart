// ignore_for_file: camel_case_types, unnecessary_new, unnecessary_this, prefer_collection_literals

class Search_model {
  List<ComplaintsList>? complaintsList;

  Search_model({this.complaintsList});

  Search_model.fromJson(Map<String, dynamic> json) {
    if (json['Complaints_List'] != null) {
      complaintsList = <ComplaintsList>[];
      json['Complaints_List'].forEach((v) {
        complaintsList!.add(new ComplaintsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.complaintsList != null) {
      data['Complaints_List'] =
          this.complaintsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ComplaintsList {
  String? complaintNo;
  String? customerName;
  String? mobileNo;
  String? address;
  Null kNo;
  String? problem;

  ComplaintsList(
      {this.complaintNo,
      this.customerName,
      this.mobileNo,
      this.address,
      this.kNo,
      this.problem});

  ComplaintsList.fromJson(Map<String, dynamic> json) {
    complaintNo = json['ComplaintNo'];
    customerName = json['Customer_name'];
    mobileNo = json['MobileNo'];
    address = json['Address'];
    kNo = json['KNo'];
    problem = json['Problem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ComplaintNo'] = this.complaintNo;
    data['Customer_name'] = this.customerName;
    data['MobileNo'] = this.mobileNo;
    data['Address'] = this.address;
    data['KNo'] = this.kNo;
    data['Problem'] = this.problem;
    return data;
  }
}
