// ignore_for_file: camel_case_types, unnecessary_new, prefer_collection_literals, unnecessary_this, unnecessary_question_mark

class Complaint_BasedOnComplaintNo {
  List<ComplaintDetail>? complaintDetail;
  List<ItemDetail>? itemDetail;

  Complaint_BasedOnComplaintNo({this.complaintDetail, this.itemDetail});

  Complaint_BasedOnComplaintNo.fromJson(Map<String, dynamic> json) {
    if (json['Complaint_Detail'] != null) {
      complaintDetail = <ComplaintDetail>[];
      json['Complaint_Detail'].forEach((v) {
        complaintDetail!.add(new ComplaintDetail.fromJson(v));
      });
    }
    if (json['Item_Detail'] != null) {
      itemDetail = <ItemDetail>[];
      json['Item_Detail'].forEach((v) {
        itemDetail!.add(new ItemDetail.fromJson(v));
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
      data['Item_Detail'] = this.itemDetail!.map((v) => v.toJson()).toList();
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
  Null? problemSince;
  String? nature;
  Null? type;
  Null? kNo;
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

class ItemDetail {
  String? iTEMCODE;
  String? iTEMNAME;
  String? bUCODE;
  String? bUNAME;
  String? cATEGORYCODE;
  String? cATEGORYNAME;
  String? mODELCODE;
  String? mODELNAME;
  int? sIZECODE;
  String? sIZENAME;
  String? cOLORCODE;
  String? cOLORNAME;

  ItemDetail(
      {this.iTEMCODE,
      this.iTEMNAME,
      this.bUCODE,
      this.bUNAME,
      this.cATEGORYCODE,
      this.cATEGORYNAME,
      this.mODELCODE,
      this.mODELNAME,
      this.sIZECODE,
      this.sIZENAME,
      this.cOLORCODE,
      this.cOLORNAME});

  ItemDetail.fromJson(Map<String, dynamic> json) {
    iTEMCODE = json['ITEM_CODE'];
    iTEMNAME = json['ITEM_NAME'];
    bUCODE = json['BU_CODE'];
    bUNAME = json['BU_NAME'];
    cATEGORYCODE = json['CATEGORY_CODE'];
    cATEGORYNAME = json['CATEGORY_NAME'];
    mODELCODE = json['MODEL_CODE'];
    mODELNAME = json['MODEL_NAME'];
    //sIZECODE = json['SIZE_CODE'];
    sIZENAME = json['SIZE_NAME'];
    cOLORCODE = json['COLOR_CODE'];
    cOLORNAME = json['COLOR_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ITEM_CODE'] = this.iTEMCODE;
    data['ITEM_NAME'] = this.iTEMNAME;
    data['BU_CODE'] = this.bUCODE;
    data['BU_NAME'] = this.bUNAME;
    data['CATEGORY_CODE'] = this.cATEGORYCODE;
    data['CATEGORY_NAME'] = this.cATEGORYNAME;
    data['MODEL_CODE'] = this.mODELCODE;
    data['MODEL_NAME'] = this.mODELNAME;
    data['SIZE_CODE'] = this.sIZECODE;
    data['SIZE_NAME'] = this.sIZENAME;
    data['COLOR_CODE'] = this.cOLORCODE;
    data['COLOR_NAME'] = this.cOLORNAME;
    return data;
  }
}
