// // ignore_for_file: unnecessary_new, camel_case_types, prefer_collection_literals, unnecessary_this

// class Payment_update {
//   List<Null>? pAYMENTDETAILS;

//   Payment_update({this.pAYMENTDETAILS});

//   Payment_update.fromJson(Map<String, dynamic> json) {
//     if (json['PAYMENT_DETAILS'] != null) {
//       pAYMENTDETAILS = <Null>[];
//       json['PAYMENT_DETAILS'].forEach((v) {
//         pAYMENTDETAILS!.add(new Null.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.pAYMENTDETAILS != null) {
//       data['PAYMENT_DETAILS'] =
//           this.pAYMENTDETAILS!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
