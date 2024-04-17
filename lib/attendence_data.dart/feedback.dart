// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:log_in/All_MENU.dart/attandance.dart';
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

  @override
  void initState() {
    super.initState();
    feedback();
  }

  feedback() async {
    var staffId = await UserSecureStorage().getStaffId();
    var body = {
      "_StaffId": staffId,
      "_Remarks": "",
      "Fromdate": "",
      "_VisitCode": "01",
      "_TenantCode": "101",
      "_Location": "110001",
    };
    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Day_Feedback"),
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
      var checkinliststring = data['string'];
      checkinliststring =
          checkinliststring.toString().replaceAll("\\r\\\\n", "\n");
      var response = data['string'];
      if (response == "true") {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("CheckIn Successfully")));
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
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                " Date",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  hintText: ' Enter Date dd-mm-yyyy',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.blue,
                height: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Day FeedBack",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  hintText: ' Enter Day FeedBack',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.blue,
                height: 5,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xffFF9800))),
                  onPressed: () {},
                  child: const Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xffFF9800))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const attandance()));
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
      )),
    );
  }
}
