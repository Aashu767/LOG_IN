class itemModel {
  String? itemName;
  String? itemID;
  String? itemQty;
  String? sTRQCCODE;
  String? itemRate;
  String? sTRMODVATVLUE;
  String? sTRPLCECODE;
  String? sTREXCREG;

  itemModel(
      {this.itemName,
      this.itemID,
      this.itemQty,
      this.sTRQCCODE,
      this.itemRate,
      this.sTRMODVATVLUE,
      this.sTRPLCECODE,
      this.sTREXCREG});

  itemModel.fromJson(Map<String, dynamic> json) {
    itemName = json['Item_Name'];
    itemID = json['Item_ID'];
    itemQty = json['Item_Qty'];
    sTRQCCODE = json['STR_QC_CODE'];
    itemRate = json['Item_Rate'];
    sTRMODVATVLUE = json['STR_MODVAT_VLUE'];
    sTRPLCECODE = json['STR_PLCE_CODE'];
    sTREXCREG = json['STR_EXC_REG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['Item_Name'] = itemName;
    data['Item_ID'] = itemID;
    data['Item_Qty'] = itemQty;
    data['STR_QC_CODE'] = sTRQCCODE;
    data['Item_Rate'] = itemRate;
    data['STR_MODVAT_VLUE'] = sTRMODVATVLUE;
    data['STR_PLCE_CODE'] = sTRPLCECODE;
    data['STR_EXC_REG'] = sTREXCREG;
    return data;
  }
}
