// ignore_for_file: camel_case_types, unused_field, use_build_context_synchronously, unused_element

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:log_in/All_MENU.dart/attandance.dart';
import 'package:log_in/utils/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class check_out extends StatefulWidget {
  const check_out({super.key});

  @override
  State<check_out> createState() => _check_outState();
}

class _check_outState extends State<check_out> {
  TextEditingController readingcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  final picker = ImagePicker();

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
  void initState() {
    super.initState();
    fetchcheckout();
    fetchcheckoutwithreading();
  }

  fetchcheckoutwithreading() async {
    var staffId = await UserSecureStorage().getStaffId();
    var body = {
      "_StaffId": staffId,
      "_Reading": "",
      "_Image": "",
      "_buffer": "",
      "_Extension": "",
      "_VisitCode": "01",
      "_TenantCode": "101",
      "_Location": "110001",
    };
    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Day_Check_Out_With_Reading"),
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

  fetchcheckout() async {
    var staffId = await UserSecureStorage().getStaffId();
    var body = {
      "_StaffId": staffId,
      "_VisitCode": "01",
      "_TenantCode": "101",
      "_Location": "110001",
    };
    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Day_Check_Out"),
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          'Day Check out',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              child: Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        'Start Reading',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      )),
                  Flexible(
                    flex: 4,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: readingcontroller,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: 'Enter the Reading',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Reading';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.blue,
              height: 5,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Reading Entered')),
                    );
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
                onPressed: () {
                  showOptions();
                },
                child: const Text(
                  "Camera",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              )
            ]),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.blue,
              height: 5,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const attandance()));
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
