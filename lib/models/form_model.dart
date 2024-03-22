// ignore_for_file: camel_case_types, unnecessary_new, unnecessary_this, prefer_collection_literals

class Complaint_BasedOnComplaintNo {
  List<ComplaintDetail>? complaintDetail;
  List<Null>? itemDetail;

  Complaint_BasedOnComplaintNo({this.complaintDetail, this.itemDetail});

  Complaint_BasedOnComplaintNo.fromJson(Map<String, dynamic> json) {
    if (json['Complaint_Detail'] != null) {
      complaintDetail = <ComplaintDetail>[];
      json['Complaint_Detail'].forEach((v) {
        complaintDetail!.add(ComplaintDetail.fromJson(v));
      });
    }
    if (json['Item_Detail'] != null) {
      itemDetail = <Null>[];
      json['Item_Detail'].forEach((v) {
        itemDetail!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.complaintDetail != null) {
      data['Complaint_Detail'] =
          this.complaintDetail!.map((v) => v.toJson()).toList();
    }
    if (this.itemDetail != null) {
      data['Item_Detail'] = this.itemDetail!;
    }
    return data;
  }
}

class ComplaintDetail {
  String? complaintNo;
  String? customerName;
  String? mobileNo;
  String? address;
  String? zone;
  String? problem;
  String? problemSince;
  String? nature;
  String? type;
  String? kNo;
  String? eMail;
  String? pinCode;
  String? mrCode;
  String? colony;
  String? aREA;
  String? status;
  String? aSSIGNTOName;
  String? assignTo;
  String? registrationDate;
  String? completionDate;
  String? buttonDisplay;

  ComplaintDetail(
      {this.complaintNo,
      this.customerName,
      this.mobileNo,
      this.address,
      this.zone,
      this.problem,
      this.problemSince,
      this.nature,
      this.type,
      this.kNo,
      this.eMail,
      this.pinCode,
      this.mrCode,
      this.colony,
      this.aREA,
      this.status,
      this.aSSIGNTOName,
      this.assignTo,
      this.registrationDate,
      this.completionDate,
      this.buttonDisplay});

  ComplaintDetail.fromJson(Map<String, dynamic> json) {
    complaintNo = json['ComplaintNo'];
    customerName = json['Customer_Name'];
    mobileNo = json['MobileNo'];
    address = json['Address'];
    zone = json['zone'];
    problem = json['Problem'];
    problemSince = json['Problem_Since'];
    nature = json['Nature'];
    type = json['type'];
    kNo = json['KNo'];
    eMail = json['eMail'];
    pinCode = json['PinCode'];
    mrCode = json['MrCode'];
    colony = json['Colony'];
    aREA = json['AREA'];
    status = json['Status'];
    aSSIGNTOName = json['ASSIGN_TO_Name'];
    assignTo = json['Assign_To'];
    registrationDate = json['Registration_Date'];
    completionDate = json['Completion_Date'];
    buttonDisplay = json['ButtonDisplay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ComplaintNo'] = this.complaintNo;
    data['Customer_Name'] = this.customerName;
    data['MobileNo'] = this.mobileNo;
    data['Address'] = this.address;
    data['zone'] = this.zone;
    data['Problem'] = this.problem;
    data['Problem_Since'] = this.problemSince;
    data['Nature'] = this.nature;
    data['type'] = this.type;
    data['KNo'] = this.kNo;
    data['eMail'] = this.eMail;
    data['PinCode'] = this.pinCode;
    data['MrCode'] = this.mrCode;
    data['Colony'] = this.colony;
    data['AREA'] = this.aREA;
    data['Status'] = this.status;
    data['ASSIGN_TO_Name'] = this.aSSIGNTOName;
    data['Assign_To'] = this.assignTo;
    data['Registration_Date'] = this.registrationDate;
    data['Completion_Date'] = this.completionDate;
    data['ButtonDisplay'] = this.buttonDisplay;
    return data;
  }
}
