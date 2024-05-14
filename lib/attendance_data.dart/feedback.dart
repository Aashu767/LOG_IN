// ignore_for_file: camel_case_types, use_build_context_synchronously, avoid_print, unused_element, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:log_in/api.dart';
import 'package:log_in/utils/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class feedback extends StatefulWidget {
  const feedback({super.key});

  @override
  State<feedback> createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  TextEditingController dateController = TextEditingController();
  TextEditingController feedbackcontroller = TextEditingController();
  String selecteddate = "";

  @override
  void initState() {
    super.initState();
  }

  feedback() async {
    var staffId = await UserSecureStorage().getStaffId();
    var body = {
      "_StaffId": staffId,
      "_Remarks": feedbackcontroller.text,
      "Fromdate": selecteddate,
      "_VisitCode": "01",
      "_TenantCode": "101",
      "_Location": "110001",
    };
    var res = await http.post(Uri.parse(AppUrl.Ws_Day_Feedback),
        headers: {
          "Accept": "application/json",
          "Content_type": "application/x-www-form-urlencoded"
        },
        body: body);
    var bodyIs = res.body;
    print("objectupdatecheckin$bodyIs");
    var statusCode = res.statusCode;
    if (statusCode == 200) {
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(bodyIs);
      var jsonString = xml2json.toParker();
      var data = jsonDecode(jsonString);
      var response = data['boolean'];
      response = response.toString().replaceAll("\\r\\\\n", "\n");
      if (response == "true") {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Successfully saved")));
        Navigator.pop(context);
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
          'Day FeedBack',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffFF9800),
      ),
      body: SingleChildScrollView(
          child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.5,
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
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      " Date :",
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
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.03,
                    ),
                    const Text(
                      "Day FeedBack :",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextFormField(
                      controller: feedbackcontroller,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]')),
                      ],
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: ' Enter Day FeedBack',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter FeedBack';
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
                                feedback();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please try again')),
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
      )),
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
      selecteddate = DateFormat('dd-MM-yyyy').format(pickedDate);
      //String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      // print(formattedDate);

      setState(() {
        dateController.text = selecteddate;
        // selecteddate = formattedDate;
        print("Date ${dateController.text}");
      });
    } else {
      print("Date is not selected");
    }
  }
}
