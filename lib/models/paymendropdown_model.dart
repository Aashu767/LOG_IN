// ignore_for_file: camel_case_types, unnecessary_new, prefer_collection_literals, unnecessary_this

// class payment_dropdown {
//   List<ITEMDETAILS>? iTEMDETAILS;
//   List<SERVICEACTION>? sERVICEACTION;
//   List<COMPLAINTSTATUS>? cOMPLAINTSTATUS;
//   List<REDRESSALSTATUS>? rEDRESSALSTATUS;
//   List<PaymentMode>? paymentMode;

//   payment_dropdown(
//       {this.iTEMDETAILS,
//       this.sERVICEACTION,
//       this.cOMPLAINTSTATUS,
//       this.rEDRESSALSTATUS,
//       this.paymentMode});

//   payment_dropdown.fromJson(Map<String, dynamic> json) {
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

class PaymentDropdown {
  List<ItemDetails>? itemDetails;
  List<ServiceAction>? serviceAction;
  List<ComplaintStatus>? complaintStatus;
  List<RedressalStatus>? redressalStatus;
  List<PaymentMode>? paymentMode;

  PaymentDropdown({
    this.itemDetails,
    this.serviceAction,
    this.complaintStatus,
    this.redressalStatus,
    this.paymentMode,
  });

  PaymentDropdown.fromJson(Map<String, dynamic> json) {
    itemDetails = <ItemDetails>[];
    json['ITEM_DETAILS']?.forEach((v) {
      itemDetails!.add(ItemDetails.fromJson(v));
    });

    serviceAction = <ServiceAction>[];
    json['SERVICE_ACTION']?.forEach((v) {
      serviceAction!.add(ServiceAction.fromJson(v));
    });

    complaintStatus = <ComplaintStatus>[];
    json['COMPLAINT_STATUS']?.forEach((v) {
      complaintStatus!.add(ComplaintStatus.fromJson(v));
    });

    redressalStatus = <RedressalStatus>[];
    json['REDRESSAL_STATUS']?.forEach((v) {
      redressalStatus!.add(RedressalStatus.fromJson(v));
    });

    paymentMode = <PaymentMode>[];
    json['Payment_Mode']?.forEach((v) {
      paymentMode!.add(PaymentMode.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ITEM_DETAILS'] = itemDetails?.map((v) => v.toJson()).toList();
    data['SERVICE_ACTION'] = serviceAction?.map((v) => v.toJson()).toList();
    data['COMPLAINT_STATUS'] = complaintStatus?.map((v) => v.toJson()).toList();
    data['REDRESSAL_STATUS'] = redressalStatus?.map((v) => v.toJson()).toList();
    data['Payment_Mode'] = paymentMode?.map((v) => v.toJson()).toList();
    return data;
  }
}

class ItemDetails {
  String? id;
  String? name;

  ItemDetails({this.id, this.name});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['Name'] = name;
    return data;
  }
}

class ServiceAction {
  String? id;
  String? name;

  ServiceAction({this.id, this.name});

  ServiceAction.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['NAME'] = name;
    return data;
  }
}

class ComplaintStatus {
  String? id;
  String? name;

  ComplaintStatus({this.id, this.name});

  ComplaintStatus.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['Name'] = name;
    return data;
  }
}

class RedressalStatus {
  String? id;
  String? name;

  RedressalStatus({this.id, this.name});

  RedressalStatus.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['Name'] = name;
    return data;
  }
}

class PaymentMode {
  String? id;
  String? name;

  PaymentMode({this.id, this.name});

  PaymentMode.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['Name'] = name;
    return data;
  }
}
