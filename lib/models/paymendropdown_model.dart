// ignore_for_file: camel_case_types, unnecessary_new, prefer_collection_literals, unnecessary_this

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
