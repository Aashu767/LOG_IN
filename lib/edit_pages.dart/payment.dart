// ignore_for_file: camel_case_types, avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:log_in/models/paymendropdown_model.dart';
import 'package:log_in/utils/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class payment extends StatefulWidget {
  const payment({super.key});

  //PE0003
  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final picker = ImagePicker();
  bool isLoading = true;
  List<PaymentMode> paymentMode = [];
  String paymentlist1 = "";
  PaymentMode? paymentval;

  @override
  void initState() {
    super.initState();
    fetchDDApi();
    updatepayment();
    savepdata();
  }

  fetchDDApi() async {
    var staffId = await UserSecureStorage().getStaffId();
    var body = {
      "USER_ID": staffId,
    };
    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_All_DropDownValue"),
        headers: {
          "Accept": "application/json",
          "Content_type": "application/x-www-form-urlencoded"
        },
        body: body);
    var bodyIs = res.body;
    var statusCode = res.statusCode;
    if (statusCode == 200) {
      debugPrint("reuseris${res.body}");
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(bodyIs);
      var jsonString = xml2json.toParker();
      var data = jsonDecode(jsonString);
      var valueliststring = data['string'];
      valueliststring = valueliststring.toString().replaceAll("\\r\\\\n", "\n");
      var valueobject = json.decode(valueliststring.toString());
      var valuelistobject = valueobject['Payment_Mode'];
      Iterable l = valuelistobject;
      setState(() {
        paymentMode = l.map((data) => PaymentMode.fromJson(data)).toList();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  updatepayment() async {
    var body = {
      "CustomerCode": "PE0003",
    };
    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_Customer_PaymentSR"),
        headers: {
          "Accept": "application/json",
          "Content_type": "application/x-www-form-urlencoded"
        },
        body: body);
    var bodyIs = res.body;
    var statusCode = res.statusCode;
    if (statusCode == 200) {
      debugPrint("reuseris${res.body}");
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(bodyIs);
      var jsonString = xml2json.toParker();
      var data = jsonDecode(jsonString);
      var valueliststring = data['string'];
      valueliststring = valueliststring.toString().replaceAll("\\r\\\\n", "\n");
      var valueobject = json.decode(valueliststring.toString());
      var valuelistobject = valueobject['SchemeSKU'];
      Iterable l = valuelistobject;
      setState(() {
        paymentMode = l.map((data) => PaymentMode.fromJson(data)).toList();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  savepdata() async {
    var body = {
      "Customer_Code": "PE0003",
      "TransactionID": "",
      "PaymentMode": "",
      "TransactionAmt": "",
      "InvoiceNo": "",
      "TransactionDate": "",
      "Remarks": "",
      "PartyName": "",
      "BankName": "",
      "AttachDocument": "",
    };
    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/WS_Insert_PaymentSR"),
        headers: {
          "Accept": "application/json",
          "Content_type": "application/x-www-form-urlencoded"
        },
        body: body);
    var bodyIs = res.body;
    var statusCode = res.statusCode;
    if (statusCode == 200) {
      debugPrint("reuseris${res.body}");
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(bodyIs);
      var jsonString = xml2json.toParker();
      var data = jsonDecode(jsonString);
      var valueliststring = data['string'];
      valueliststring = valueliststring.toString().replaceAll("\\r\\\\n", "\n");
      var valueobject = json.decode(valueliststring.toString());
      var valuelistobject = valueobject['Payment_Mode'];
      Iterable l = valuelistobject;
      setState(() {
        paymentMode = l.map((data) => PaymentMode.fromJson(data)).toList();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {}
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {}
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF9FAFF),
        appBar: AppBar(
          backgroundColor: const Color(0xffFF9800),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          title: const Text('Payment Details'),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        body: SingleChildScrollView(
            child: Card(
                margin: const EdgeInsets.all(16),
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Enter Transaction ID',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter ID';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Enter Customer Name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Name';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Enter Bank Name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Bank enter Name';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: StatefulBuilder(builder:
                                (BuildContext context,
                                    StateSetter dropDownState) {
                              return DropdownButton<PaymentMode>(
                                underline: Container(
                                  height: 0,
                                  color: Colors.transparent,
                                ),
                                value: paymentval,
                                hint: const Text(
                                  '   Payment Mode*',
                                  style: TextStyle(color: Colors.black),
                                ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                items: paymentMode.map((PaymentMode payment) {
                                  return DropdownMenuItem<PaymentMode>(
                                    value: payment,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        payment.id!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (PaymentMode? val) {
                                  dropDownState(() {
                                    setState(() {
                                      paymentlist1 = val!.id!;
                                      paymentval = val;
                                    });
                                  });
                                },
                              );
                            }),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: TextFormField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Enter Amount',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter amount';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(children: [
                              IconButton(
                                onPressed: () => {
                                  _selectdate(context),
                                },
                                icon: const Icon(
                                  Icons.calendar_today,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  dateController.text == ""
                                      ? 'Transaction Date *'
                                      : dateController.text,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(children: [
                              IconButton(
                                onPressed: showOptions,
                                icon: const Icon(
                                  (Icons.add_a_photo),
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  'Picture Taken',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.38,
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                  Color(0xffFF9800),
                                )),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Form Submitted')),
                                    );
                                  }
                                },
                                child: const Text('Save',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))));
  }

  _selectdate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      print(formattedDate);

      setState(() {
        dateController.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }
}
