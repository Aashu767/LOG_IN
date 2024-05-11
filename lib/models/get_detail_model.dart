// ignore_for_file: camel_case_types, unnecessary_this, unnecessary_new, prefer_collection_literals

class PaymentdetailModel {
  int? paymentId;
  String? transactionID;
  String? userCode;
  String? applicationNo;
  String? feeDescription;
  String? transactionAmount;
  String? transactionDate;
  String? transactionResult;
  String? paymentMode;
  String? invocieno;
  String? remarks;
  String? entryDate;
  String? partyName;
  String? bankName;
  String? attachedDocument;

  PaymentdetailModel(
      {this.paymentId,
      this.transactionID,
      this.userCode,
      this.applicationNo,
      this.feeDescription,
      this.transactionAmount,
      this.transactionDate,
      this.transactionResult,
      this.paymentMode,
      this.invocieno,
      this.remarks,
      this.entryDate,
      this.partyName,
      this.bankName,
      this.attachedDocument});

  PaymentdetailModel.fromJson(Map<String, dynamic> json) {
    paymentId = json['PaymentId'];
    transactionID = json['Transaction_ID'];
    userCode = json['User_Code'];
    applicationNo = json['Application_No'];
    feeDescription = json['Fee_Description'];
    transactionAmount = json['Transaction_Amount'];
    transactionDate = json['Transaction_Date'];
    transactionResult = json['Transaction_Result'];
    paymentMode = json['Payment_Mode'];
    invocieno = json['invocieno'];
    remarks = json['Remarks'];
    entryDate = json['Entry_Date'];
    partyName = json['PartyName'];
    bankName = json['BankName'];
    attachedDocument = json['AttachedDocument'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PaymentId'] = this.paymentId;
    data['Transaction_ID'] = this.transactionID;
    data['User_Code'] = this.userCode;
    data['Application_No'] = this.applicationNo;
    data['Fee_Description'] = this.feeDescription;
    data['Transaction_Amount'] = this.transactionAmount;
    data['Transaction_Date'] = this.transactionDate;
    data['Transaction_Result'] = this.transactionResult;
    data['Payment_Mode'] = this.paymentMode;
    data['invocieno'] = this.invocieno;
    data['Remarks'] = this.remarks;
    data['Entry_Date'] = this.entryDate;
    data['PartyName'] = this.partyName;
    data['BankName'] = this.bankName;
    data['AttachedDocument'] = this.attachedDocument;
    return data;
  }
}
