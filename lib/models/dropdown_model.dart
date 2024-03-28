// // ignore_for_file: camel_case_types, unnecessary_new, prefer_collection_literals, unnecessary_this

// class DropDownValue_model {
//   List<ITEMDETAILS>? iTEMDETAILS;
//   List<SERVICEACTION>? sERVICEACTION;
//   List<COMPLAINTSTATUS>? cOMPLAINTSTATUS;
//   List<REDRESSALSTATUS>? rEDRESSALSTATUS;
//   List<PaymentMode>? paymentMode;

//   DropDownValue_model(
//       {this.iTEMDETAILS,
//       this.sERVICEACTION,
//       this.cOMPLAINTSTATUS,
//       this.rEDRESSALSTATUS,
//       this.paymentMode});

//   DropDownValue_model.fromJson(Map<String, dynamic> json) {
//     if (json['ITEM_DETAILS'] != null) {
//       iTEMDETAILS = <ITEMDETAILS>[];
//       json['ITEM_DETAILS'].forEach((v) {
//         iTEMDETAILS!.add(new ITEMDETAILS.fromJson(v));
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
//     if (json['Payment_Mode'] != null) {
//       paymentMode = <PaymentMode>[];
//       json['Payment_Mode'].forEach((v) {
//         paymentMode!.add(new PaymentMode.fromJson(v));
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
//     if (this.paymentMode != null) {
//       data['Payment_Mode'] = this.paymentMode!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ITEMDETAILS {
//   String? iD;
//   String? name;

//   ITEMDETAILS({this.iD, this.name});

//   ITEMDETAILS.fromJson(Map<String, dynamic> json) {
//     iD = json['ID'];
//     name = json['Name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ID'] = this.iD;
//     data['Name'] = this.name;
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