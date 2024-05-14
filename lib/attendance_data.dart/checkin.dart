// ignore_for_file: camel_case_types, unused_field, use_build_context_synchronously, unused_element, avoid_print, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:log_in/utils/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class check_in extends StatefulWidget {
  const check_in({super.key});

  @override
  State<check_in> createState() => _check_inState();
}

class _check_inState extends State<check_in> {
  TextEditingController readingcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  bool isLoading = true;
  File? _imgFile;
  String img64 = "";

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
  void initState() {
    super.initState();
  }

  checkinwithreading() async {
    var staffId = await UserSecureStorage().getStaffId();

    var body = {
      "_StaffId": staffId,
      "_Reading": readingcontroller.text,
      "_Image": img64,
      "_buffer": "",
      "_Extension": "",
      "_VisitCode": "01",
      "_TenantCode": "101",
      "_Location": "110001",
    };
    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Day_Check_In_With_Reading"),
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
            const SnackBar(content: Text("CheckIn Successfully")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response)));
      }
    }
  }

  checkin() async {
    var staffId = await UserSecureStorage().getStaffId();
    var body = {
      "_StaffId": staffId,
      "_VisitCode": "01",
      "_TenantCode": "101",
      "_Location": "110001",
    };
    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Day_Check_In"),
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
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: const Text(
          'Day Check In',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffFF9800),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.5,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: const Color(0xffDEE4F4),
          margin: const EdgeInsets.all(15),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Start Reading :',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: readingcontroller,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  const SizedBox(
                    height: 10,
                  ),
                  _imgFile == null
                      ? Container()
                      : Image.file(
                          _imgFile!,
                          width: 700,
                          height: 100,
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              backgroundColor: const MaterialStatePropertyAll(
                                Color(0xffFF9800),
                              )),
                          onPressed: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('check in')),
                              );
                            } else if (img64 == "") {
                              checkin();
                            } else {
                              checkinwithreading();
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              backgroundColor: const MaterialStatePropertyAll(
                                Color(0xffFF9800),
                              )),
                          onPressed: () {
                            showOptions();
                          },
                          child: const Text(
                            "Camera",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
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
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
