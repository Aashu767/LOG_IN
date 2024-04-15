// ignore_for_file: camel_case_types, unnecessary_null_comparison, avoid_unnecessary_containers, unused_element, avoid_print, unused_field, must_be_immutable, use_super_parameters

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:log_in/edit_pages.dart/complaint.dart';
import 'package:image_picker/image_picker.dart';
import 'package:log_in/models/paymendropdown_model.dart';
import 'package:log_in/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

class comp_update extends StatefulWidget {
  String compno;
  comp_update({Key? key, required this.compno}) : super(key: key);

  @override
  State<comp_update> createState() => _comp_updateState();
}

class _comp_updateState extends State<comp_update> {
  String _dropDownValue = "";
  String _dropDownValue1 = "";
  String _dropDownValue2 = "";
  String _dropDownValue3 = "";
  String _dropDownValue4 = "";
  String _dropDownValue5 = "";
  String selectedDate = 'Tap to select date';
  late File _image;
  final picker = ImagePicker();
  List<ServiceAction> serviceact = [];
  bool isLoading = true;
  ServiceAction? actionval;

  @override
  void initState() {
    super.initState();
    fetchDDUApi();
  }

  fetchDDUApi() async {
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
      // debugPrint("reuseris${res.body}");
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(bodyIs);
      var jsonString = xml2json.toParker();
      var data = jsonDecode(jsonString);
      var ddliststring = data['string'];
      ddliststring = ddliststring.toString().replaceAll("\\r\\\\n", "\n");
      var ddobject = json.decode(ddliststring.toString());
      var ddlistobject = ddobject['SERVICE_ACTION'];
      Iterable l = ddlistobject;
      setState(() {
        serviceact = l.map((data) => ServiceAction.fromJson(data)).toList();
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
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
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

  _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2020),
    );
    if (d != null) {
      setState(() {
        selectedDate = DateFormat("dd-MM-yyyy").format(d);
      });
    }
  }

  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFF9800),
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text('Complaints Update'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: SingleChildScrollView(
          child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Complain No   :-',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        widget.compno,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: DropdownButton(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    hint: _dropDownValue == ""
                        ? const Text('Item Name')
                        : Text(
                            _dropDownValue,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    items: ['One', 'Two', 'Three', 'four'].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _dropDownValue = val!;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  padding: const EdgeInsets.all(8.0),
                  child: const Row(children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Actual Problem',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return DropdownButton<ServiceAction>(
                      value: actionval,
                      hint: const Text(
                        'Action Taken ',
                        style: TextStyle(color: Colors.black),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      items: serviceact.map((ServiceAction serviceact) {
                        return DropdownMenuItem<ServiceAction>(
                          value: serviceact,
                          child: Text(
                            serviceact.name!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (ServiceAction? val) {
                        dropDownState(() {
                          setState(() {
                            _dropDownValue1 = val!.id!;
                            actionval = val;
                          });
                        });
                      },
                    );
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        style: BorderStyle.solid,
                        color: Colors.black,
                        width: 2.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    IconButton(
                      onPressed: () => {
                        _selectdate(context),
                      },
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        dateController.text == ""
                            ? 'Visit Date'
                            : dateController.text,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  padding: const EdgeInsets.all(8.0),
                  child: const Row(children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Actual Closer',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: DropdownButton(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    hint: _dropDownValue2 == ""
                        ? const Text('Select Status ')
                        : Text(
                            _dropDownValue2,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    items: [
                      'Completed',
                      'Pending',
                      'Active',
                      'Approved',
                      'Lost',
                      'Rejected',
                      'Force Closed',
                      'Approved',
                      'Wrong Allocation',
                    ].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _dropDownValue2 = val!;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: DropdownButton(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    hint: _dropDownValue3 == ""
                        ? const Text('Select Service Location')
                        : Text(
                            _dropDownValue3,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    items: [
                      'In CIty',
                      'Out City (25-40)',
                      'Out City (Above 40)',
                      'Out City Actual',
                    ].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _dropDownValue3 = val!;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: DropdownButton(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    hint: _dropDownValue4 == ""
                        ? const Text('Select Defected Type-Code')
                        : Text(
                            _dropDownValue4,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    items: [
                      'Batt Low-10',
                      'Break-10',
                      'Damage-10',
                      'Helter Damage-53',
                      'Low Batter-53',
                      'New Part-30',
                      'New Part-39',
                      'New Part-42',
                      'Not Working-10',
                    ].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _dropDownValue4 = val!;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: DropdownButton(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    hint: _dropDownValue5 == ""
                        ? const Text('Select Call Catogery')
                        : Text(
                            _dropDownValue5,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    items: [
                      'Transit Damage',
                      'Fresh Defective',
                      'Used',
                      'Inspection',
                    ].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _dropDownValue5 = val!;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        CupertinoIcons.pencil,
                        color: Colors.black,
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Signature',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    IconButton(
                      onPressed: showOptions,
                      icon: const Icon(
                        (Icons.add_a_photo),
                        color: Colors.black,
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Picture Taken',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.thumb_up_alt_outlined,
                        color: Colors.black,
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'FeedBack(Remark)',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.thumb_up_alt_outlined,
                        color: Colors.black,
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Tech Remark',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.thumb_up_alt_outlined,
                        color: Colors.black,
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Happy Code',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                    Color(0xffFF9800),
                  )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Complaints(
                                  zoneid: "",
                                  menuid: "",
                                )));
                  },
                  child: const Text(
                    "UPDATE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
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
