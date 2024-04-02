// // // ignore_for_file: camel_case_types

// // ignore_for_file: camel_case_types

// class dropd_model {
//   List<ITEMDETAILS>? iTEMDETAILS;
//   List<SERVICEACTION>? sERVICEACTION;
//   List<PaymentMode>? paymentMode;

//   dropd_model({this.iTEMDETAILS, this.sERVICEACTION, this.paymentMode});

//   dropd_model.fromJson(Map<String, dynamic> json) {
//     if (json['ITEM_DETAILS'] != null) {
//       iTEMDETAILS = <ITEMDETAILS>[];
//       json['ITEM_DETAILS'].forEach((v) {
//         iTEMDETAILS!.add(ITEMDETAILS.fromJson(v));
//       });
//     }
//     if (json['SERVICE_ACTION'] != null) {
//       sERVICEACTION = <SERVICEACTION>[];
//       json['SERVICE_ACTION'].forEach((v) {
//         sERVICEACTION!.add(SERVICEACTION.fromJson(v));
//       });
//     }
//     if (json['Payment_Mode'] != null) {
//       paymentMode = <PaymentMode>[];
//       json['Payment_Mode'].forEach((v) {
//         paymentMode!.add(PaymentMode.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (iTEMDETAILS != null) {
//       data['ITEM_DETAILS'] = iTEMDETAILS!.map((v) => v.toJson()).toList();
//     }
//     if (sERVICEACTION != null) {
//       data['SERVICE_ACTION'] = sERVICEACTION!.map((v) => v.toJson()).toList();
//     }

//     if (paymentMode != null) {
//       data['Payment_Mode'] = paymentMode!.map((v) => v.toJson()).toList();
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
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['ID'] = iD;
//     data['Name'] = name;
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
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['ID'] = iD;
//     data['NAME'] = nAME;
//     return data;
//   }
// }
