// ignore_for_file: camel_case_types, avoid_print, must_be_immutable, use_key_in_widget_constructors, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:log_in/api.dart';
import 'package:log_in/models/get_detail_model.dart';
import 'package:log_in/models/paymendropdown_model.dart';
import 'package:log_in/utils/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class payment extends StatefulWidget {
  String complno;
  payment({Key? key, required this.complno});

  //PE0003
  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController transactionidController = TextEditingController();
  TextEditingController customernameController = TextEditingController();
  TextEditingController banknameController = TextEditingController();
  final picker = ImagePicker();
  bool isLoading = true;
  File? _imgFile;
  String img64 = "";
  List<PaymentMode> paymentMode = [];
  List<PaymentdetailModel> paymentdetail = [];
  String paymentlist1 = "";
  PaymentMode? paymentval;

  @override
  void initState() {
    super.initState();
    fetchDDApi();
    updatepayment();
  }

  fetchDDApi() async {
    var staffId = await UserSecureStorage().getStaffId();
    var body = {
      "USER_ID": staffId,
    };
    var res = await http.post(Uri.parse(AppUrl.Ws_Get_All_DropDownValue),
        headers: {
          "Accept": "application/json",
          "Content_type": "application/x-www-form-urlencoded"
        },
        body: body);
    var bodyIs = res.body;
    var statusCode = res.statusCode;
    if (statusCode == 200) {
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
      "CustomerCode": widget.complno,
    };
    var res = await http.post(Uri.parse(AppUrl.Ws_Get_Customer_PaymentSR),
        headers: {
          "Accept": "application/json",
          "Content_type": "application/x-www-form-urlencoded"
        },
        body: body);
    var bodyIs = res.body;
    var statusCode = res.statusCode;
    if (statusCode == 200) {
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(bodyIs);
      var jsonString = xml2json.toParker();
      var data = jsonDecode(jsonString);
      var valueliststring = data['string'];
      valueliststring = valueliststring.toString().replaceAll("\\r\\\\n", "\n");
      var valueobject = json.decode(valueliststring.toString());
      var valuelistobject = valueobject['PAYMENT_DETAILS'];
      Iterable l = valuelistobject;
      setState(() {
        paymentdetail =
            l.map((data) => PaymentdetailModel.fromJson(data)).toList();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  savepdata() async {
    var body = {
      "Customer_Code": widget.complno,
      "TransactionID": transactionidController.text,
      "PaymentMode": paymentlist1,
      "TransactionAmt": _amountController.text,
      "InvoiceNo": "",
      "TransactionDate": dateController.text,
      "Remarks": "",
      "PartyName": customernameController.text,
      "BankName": banknameController.text,
      "AttachDocument": img64,
    };
    var res = await http.post(Uri.parse(AppUrl.WS_Insert_PaymentSR),
        headers: {
          "Accept": "application/json",
          "Content_type": "application/x-www-form-urlencoded"
        },
        body: body);
    var bodyIs = res.body;
    var statusCode = res.statusCode;
    if (statusCode == 200) {
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(bodyIs);
      var jsonString = xml2json.toParker();
      var data = jsonDecode(jsonString);
      var valueliststring = data['string'];
      valueliststring = valueliststring.toString().replaceAll("\\r\\\\n", "\n");
      var valueobject = json.decode(valueliststring.toString());
      var valuelistobject = valueobject['SchemeSKU'];
      setState(() {
        if (valuelistobject == "Data saved Successfully.") {
          Navigator.pop(context);
        } else {
          print("error");
        }
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future getImageFromGallery(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) return;
    setState(() {
      _imgFile = File(pickedFile.path);
      imagetobase64(_imgFile!);
    });
  }

  imagetobase64(File img) {
    final bytes = io.File(img.path).readAsBytesSync();
    img64 = base64Encode(bytes);
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
              getImageFromGallery(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery(ImageSource.camera);
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
                              controller: transactionidController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: TextFormField(
                              controller: customernameController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z\s]')),
                              ],
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: TextFormField(
                              controller: banknameController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z\s]')),
                              ],
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: TextFormField(
                              controller: _amountController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          InkWell(
                            onTap: () {
                              _selectdate(context);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Row(children: [
                                    Text(
                                      dateController.text == ""
                                          ? ' Transaction Date: *'
                                          : dateController.text,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          InkWell(
                            onTap: () {
                              showOptions();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: SizedBox(
                                  width: 150,
                                  child: Row(children: [
                                    Image.asset("assets/image/camera.png"),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    _imgFile == null
                                        ? const Text(
                                            'Picture Taken',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          )
                                        : Image.file(
                                            _imgFile!,
                                          ),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
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
                                  savepdata();
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
