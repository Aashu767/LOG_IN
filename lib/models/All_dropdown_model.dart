// ignore_for_file: file_names
// class All_dropdown {
//   List<Null>? iTEMDETAILS;
//   List<SERVICEACTION>? sERVICEACTION;
//   List<COMPLAINTSTATUS>? cOMPLAINTSTATUS;
//   List<REDRESSALSTATUS>? rEDRESSALSTATUS;
//   List<CATEGORY>? cATEGORY;
//   List<CALLCATEGORY>? cALLCATEGORY;
//   List<SERVICELOCATION>? sERVICELOCATION;
//   List<SERVICESTATUS>? sERVICESTATUS;
//   List<STAFF>? sTAFF;
//   List<CUSTOMERTYPE>? cUSTOMERTYPE;
//   List<STATE>? sTATE;
//   List<DISTRICT>? dISTRICT;
//   List<CITY>? cITY;
//   List<DEFECTTYPE>? dEFECTTYPE;

//   All_dropdown(
//       {this.iTEMDETAILS,
//       this.sERVICEACTION,
//       this.cOMPLAINTSTATUS,
//       this.rEDRESSALSTATUS,
//       this.cATEGORY,
//       this.cALLCATEGORY,
//       this.sERVICELOCATION,
//       this.sERVICESTATUS,
//       this.sTAFF,
//       this.cUSTOMERTYPE,
//       this.sTATE,
//       this.dISTRICT,
//       this.cITY,
//       this.dEFECTTYPE});

//   All_dropdown.fromJson(Map<String, dynamic> json) {
//     if (json['ITEM_DETAILS'] != null) {
//       iTEMDETAILS = <Null>[];
//       json['ITEM_DETAILS'].forEach((v) {
//         iTEMDETAILS!.add(new Null.fromJson(v));
//       });
//     }
//     if (json['SERVICE_ACTION'] != null) {
//       sERVICEACTION = <SERVICEACTION>[];
//       json['SERVICE_ACTION'].forEach((v) {
//         sERVICEACTION!.add(new SERVICEACTION.fromJson(v));
//       });
//     }
//     if (json['COMPLAINT_STATUS'] != null) {
//       cOMPLAINTSTATUS = <COMPLAINTSTATUS>[];
//       json['COMPLAINT_STATUS'].forEach((v) {
//         cOMPLAINTSTATUS!.add(new COMPLAINTSTATUS.fromJson(v));
//       });
//     }
//     if (json['REDRESSAL_STATUS'] != null) {
//       rEDRESSALSTATUS = <REDRESSALSTATUS>[];
//       json['REDRESSAL_STATUS'].forEach((v) {
//         rEDRESSALSTATUS!.add(new REDRESSALSTATUS.fromJson(v));
//       });
//     }
//     if (json['CATEGORY'] != null) {
//       cATEGORY = <CATEGORY>[];
//       json['CATEGORY'].forEach((v) {
//         cATEGORY!.add(new CATEGORY.fromJson(v));
//       });
//     }
//     if (json['CALL_CATEGORY'] != null) {
//       cALLCATEGORY = <CALLCATEGORY>[];
//       json['CALL_CATEGORY'].forEach((v) {
//         cALLCATEGORY!.add(new CALLCATEGORY.fromJson(v));
//       });
//     }
//     if (json['SERVICE_LOCATION'] != null) {
//       sERVICELOCATION = <SERVICELOCATION>[];
//       json['SERVICE_LOCATION'].forEach((v) {
//         sERVICELOCATION!.add(new SERVICELOCATION.fromJson(v));
//       });
//     }
//     if (json['SERVICE_STATUS'] != null) {
//       sERVICESTATUS = <SERVICESTATUS>[];
//       json['SERVICE_STATUS'].forEach((v) {
//         sERVICESTATUS!.add(new SERVICESTATUS.fromJson(v));
//       });
//     }
//     if (json['STAFF'] != null) {
//       sTAFF = <STAFF>[];
//       json['STAFF'].forEach((v) {
//         sTAFF!.add(new STAFF.fromJson(v));
//       });
//     }
//     if (json['CUSTOMER_TYPE'] != null) {
//       cUSTOMERTYPE = <CUSTOMERTYPE>[];
//       json['CUSTOMER_TYPE'].forEach((v) {
//         cUSTOMERTYPE!.add(new CUSTOMERTYPE.fromJson(v));
//       });
//     }
//     if (json['STATE'] != null) {
//       sTATE = <STATE>[];
//       json['STATE'].forEach((v) {
//         sTATE!.add(new STATE.fromJson(v));
//       });
//     }
//     if (json['DISTRICT'] != null) {
//       dISTRICT = <DISTRICT>[];
//       json['DISTRICT'].forEach((v) {
//         dISTRICT!.add(new DISTRICT.fromJson(v));
//       });
//     }
//     if (json['CITY'] != null) {
//       cITY = <CITY>[];
//       json['CITY'].forEach((v) {
//         cITY!.add(new CITY.fromJson(v));
//       });
//     }
//     if (json['DEFECT_TYPE'] != null) {
//       dEFECTTYPE = <DEFECTTYPE>[];
//       json['DEFECT_TYPE'].forEach((v) {
//         dEFECTTYPE!.add(new DEFECTTYPE.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.iTEMDETAILS != null) {
//       data['ITEM_DETAILS'] = this.iTEMDETAILS!.map((v) => v.toJson()).toList();
//     }
//     if (this.sERVICEACTION != null) {
//       data['SERVICE_ACTION'] =
//           this.sERVICEACTION!.map((v) => v.toJson()).toList();
//     }
//     if (this.cOMPLAINTSTATUS != null) {
//       data['COMPLAINT_STATUS'] =
//           this.cOMPLAINTSTATUS!.map((v) => v.toJson()).toList();
//     }
//     if (this.rEDRESSALSTATUS != null) {
//       data['REDRESSAL_STATUS'] =
//           this.rEDRESSALSTATUS!.map((v) => v.toJson()).toList();
//     }
//     if (this.cATEGORY != null) {
//       data['CATEGORY'] = this.cATEGORY!.map((v) => v.toJson()).toList();
//     }
//     if (this.cALLCATEGORY != null) {
//       data['CALL_CATEGORY'] =
//           this.cALLCATEGORY!.map((v) => v.toJson()).toList();
//     }
//     if (this.sERVICELOCATION != null) {
//       data['SERVICE_LOCATION'] =
//           this.sERVICELOCATION!.map((v) => v.toJson()).toList();
//     }
//     if (this.sERVICESTATUS != null) {
//       data['SERVICE_STATUS'] =
//           this.sERVICESTATUS!.map((v) => v.toJson()).toList();
//     }
//     if (this.sTAFF != null) {
//       data['STAFF'] = this.sTAFF!.map((v) => v.toJson()).toList();
//     }
//     if (this.cUSTOMERTYPE != null) {
//       data['CUSTOMER_TYPE'] =
//           this.cUSTOMERTYPE!.map((v) => v.toJson()).toList();
//     }
//     if (this.sTATE != null) {
//       data['STATE'] = this.sTATE!.map((v) => v.toJson()).toList();
//     }
//     if (this.dISTRICT != null) {
//       data['DISTRICT'] = this.dISTRICT!.map((v) => v.toJson()).toList();
//     }
//     if (this.cITY != null) {
//       data['CITY'] = this.cITY!.map((v) => v.toJson()).toList();
//     }
//     if (this.dEFECTTYPE != null) {
//       data['DEFECT_TYPE'] = this.dEFECTTYPE!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class SERVICEACTION {
//   String? iD;
//   String? nAME;

//   SERVICEACTION({this.iD, this.nAME});

//   SERVICEACTION.fromJson(Map<String, dynamic> json) {
//     iD = json['ID'];
//     nAME = json['NAME'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ID'] = this.iD;
//     data['NAME'] = this.nAME;
//     return data;
//   }
// }

// class CATEGORY {
//   String? sYSCDSCODEVALUE;
//   String? sYSCDSCODEDESC;

//   CATEGORY({this.sYSCDSCODEVALUE, this.sYSCDSCODEDESC});

//   CATEGORY.fromJson(Map<String, dynamic> json) {
//     sYSCDSCODEVALUE = json['SYSCDS_CODE_VALUE'];
//     sYSCDSCODEDESC = json['SYSCDS_CODE_DESC'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['SYSCDS_CODE_VALUE'] = this.sYSCDSCODEVALUE;
//     data['SYSCDS_CODE_DESC'] = this.sYSCDSCODEDESC;
//     return data;
//   }
// }

// class STAFF {
//   String? sYSCDSCODEVALUE;
//   String? nAME;

//   STAFF({this.sYSCDSCODEVALUE, this.nAME});

//   STAFF.fromJson(Map<String, dynamic> json) {
//     sYSCDSCODEVALUE = json['SYSCDS_CODE_VALUE'];
//     nAME = json['NAME'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['SYSCDS_CODE_VALUE'] = this.sYSCDSCODEVALUE;
//     data['NAME'] = this.nAME;
//     return data;
//   }
// }
