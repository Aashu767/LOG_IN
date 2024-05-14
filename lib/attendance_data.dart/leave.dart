// ignore_for_file: camel_case_types, unused_element, avoid_print, use_build_context_synchronously, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:log_in/api.dart';
import 'package:log_in/utils/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class leave extends StatefulWidget {
  const leave({super.key});

  @override
  State<leave> createState() => _leaveState();
}

class _leaveState extends State<leave> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController reasoncontroller = TextEditingController();
  TextEditingController dayscontroller = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController dateController1 = TextEditingController();
  TextEditingController remarkscontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  leave() async {
    var staffId = await UserSecureStorage().getStaffId();
    var body = {
      "_StaffId": staffId,
      "LeaveDays": dayscontroller.text,
      "_Remarks": remarkscontroller.text,
      "FromDate": dateController.text,
      "Todate": dateController1.text,
      "_VisitCode": "01",
      "_TenantCode": "101",
      "_Location": "110001",
      "_AStatus": "",
    };
    var res = await http.post(Uri.parse(AppUrl.Ws_Leave_Request),
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
      var response = data['boolean'];
      response = response.toString().replaceAll("\\r\\\\n", "\n");
      if (response == true) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Checkout Successfully")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFF),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: const Text(
          'Leave Request',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffFF9800),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.8,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: const Color(0xffDEE4F4),
            margin: const EdgeInsets.all(15),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Reason Of Leave :",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextFormField(
                      controller: reasoncontroller,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]')),
                      ],
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(5),
                          hintText: 'Enter Reason For Leave',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Reason';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "No Of Days :",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextFormField(
                      controller: dayscontroller,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: '  Enter No.Of Days ',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter No.Of Days';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "From Date :",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _selectdate(context);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Row(children: [
                              Text(
                                dateController.text == ""
                                    ? ' Enter Date '
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "To Date :",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _selectdate1(context);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Row(children: [
                              Text(
                                dateController1.text == ""
                                    ? ' Enter Date '
                                    : dateController1.text,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Remarks :",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextFormField(
                      controller: remarkscontroller,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]')),
                      ],
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: ' Enter Remarks',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Remark';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xffFF9800),
                                )),
                            onPressed: () {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Saved')),
                                );
                              }
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xffFF9800),
                                )),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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

  _selectdate1(BuildContext context) async {
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
        dateController1.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }
}
