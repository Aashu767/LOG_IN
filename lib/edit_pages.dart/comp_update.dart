// ignore_for_file: camel_case_types, unnecessary_null_comparison, avoid_unnecessary_containers, unused_element, avoid_print, unused_field, must_be_immutable, use_super_parameters, non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:log_in/edit_pages.dart/complaint.dart';
import 'package:image_picker/image_picker.dart';
import 'package:log_in/models/All_dropdown_model.dart';
import 'package:log_in/models/paymendropdown_model.dart';
import 'package:log_in/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

class AddedItem {
  final String name;
  final int quantity;
  final double rate;

  AddedItem({
    required this.name,
    required this.quantity,
    required this.rate,
  });
}

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
  List<ItemDetails> itemdetail = [];
  List<ServiceAction> serviceact = [];
  List<ComplaintStatus> Compstatus = [];
  List<SERVICEACTION> servieloctiondropdwn = [];
  List<SERVICEACTION> defectypedropdown = [];
  List<SERVICEACTION> callcatdropdown = [];
  TextEditingController Qty = TextEditingController();
  TextEditingController Rate = TextEditingController();
  List<AddedItem> addedItems = [];
  bool isLoading = true;
  ServiceAction? actionval;
  ItemDetails? itemval;
  ComplaintStatus? statusval;
  SERVICEACTION? serviceloc;
  SERVICEACTION? defectcode;
  SERVICEACTION? callcode;

  @override
  void initState() {
    super.initState();
    DDUApi();
    fetchservice();
  }

  DDUApi() async {
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
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(bodyIs);
      var jsonString = xml2json.toParker();
      var data = jsonDecode(jsonString);

      var itemliststring = data['string'];
      itemliststring = itemliststring.toString().replaceAll("\\r\\\\n", "\n");
      var itemobject = json.decode(itemliststring.toString());
      var itmelistobject = itemobject['ITEM_DETAILS'];
      Iterable item = itmelistobject;
      var actionlistobject = itemobject['SERVICE_ACTION'];
      Iterable service = actionlistobject;
      var statuslistobject = itemobject['COMPLAINT_STATUS'];
      Iterable status = statuslistobject;

      setState(() {
        itemdetail = item.map((data) => ItemDetails.fromJson(data)).toList();
        serviceact =
            service.map((data) => ServiceAction.fromJson(data)).toList();
        Compstatus =
            status.map((data) => ComplaintStatus.fromJson(data)).toList();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  fetchservice() async {
    var body = {
      "ProductCode": "0",
    };
    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_All_DropDownValueSR"),
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

      var itemliststring = data['string'];
      itemliststring = itemliststring.toString().replaceAll("\\r\\\\n", "\n");
      var itemobject = json.decode(itemliststring.toString());
      var serviceobject = itemobject['SERVICE_LOCATION'];
      Iterable item = serviceobject;
      var deftypelistobject = itemobject['DEFECT_TYPE'];
      Iterable service = deftypelistobject;
      var callcatobject = itemobject['CALL_CATEGORY'];
      Iterable status = callcatobject;

      setState(() {
        servieloctiondropdwn =
            item.map((data) => SERVICEACTION.fromJson(data)).toList();
        defectypedropdown =
            service.map((data) => SERVICEACTION.fromJson(data)).toList();
        callcatdropdown =
            status.map((data) => SERVICEACTION.fromJson(data)).toList();
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
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        '   Complaint No  :-',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        widget.compno,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide.none,
                            bottom: BorderSide.none,
                            left: BorderSide.none,
                            right: BorderSide(),
                          ),
                        ),
                        child: StatefulBuilder(builder:
                            (BuildContext context, StateSetter dropDownState) {
                          return DropdownButton<ItemDetails>(
                              underline: Container(
                                height: 0,
                                color: Colors.transparent,
                              ),
                              value: itemval,
                              hint: const Text(
                                "   Item Name",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              items: itemdetail.map(
                                (ItemDetails itemdetail) {
                                  return DropdownMenuItem<ItemDetails>(
                                    value: itemdetail,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        itemdetail.name!,
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (ItemDetails? val) {
                                dropDownState(() {
                                  setState(() {
                                    _dropDownValue = val!.id!;
                                    itemval = val;
                                  });
                                });
                              });
                        }),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide.none,
                            bottom: BorderSide.none,
                            left: BorderSide.none,
                            right: BorderSide(),
                          ),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: Qty,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(hintText: 'Qty'),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide.none,
                            bottom: BorderSide.none,
                            left: BorderSide.none,
                            right: BorderSide(),
                          ),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: Rate,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(hintText: 'Rate'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (itemval != null &&
                              Qty.text.isNotEmpty &&
                              Rate.text.isNotEmpty) {
                            setState(() {
                              addedItems.add(AddedItem(
                                name: itemval!.name!,
                                quantity: int.parse(Qty.text),
                                rate: double.parse(Rate.text),
                              ));
                            });
                            Qty.clear();
                            Rate.clear();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.189,
                          decoration: const BoxDecoration(
                            color: Color(0xffFF9800),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          child: const Center(
                            child: Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ListView.builder(
                    itemCount: addedItems.length,
                    itemBuilder: (context, index) {
                      final item = addedItems[index];

                      return Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide.none,
                                  bottom: BorderSide.none,
                                  left: BorderSide.none,
                                  right: BorderSide(),
                                ),
                              ),
                              child: Center(child: Text(' ${item.name}')),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide.none,
                                  bottom: BorderSide.none,
                                  left: BorderSide.none,
                                  right: BorderSide(),
                                ),
                              ),
                              child: Center(child: Text('${item.quantity}')),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide.none,
                                  bottom: BorderSide.none,
                                  left: BorderSide.none,
                                  right: BorderSide(),
                                ),
                              ),
                              child: Center(child: Text('${item.rate}')),
                            ),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.13,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        addedItems.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                  ),
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Row(children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Actual Problem',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return DropdownButton<ServiceAction>(
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      value: actionval,
                      hint: const Text(
                        '  Action Taken',
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              serviceact.name!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5.0),
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
                            ? 'Visit Date'
                            : dateController.text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Row(children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        '  Actual Closer',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return DropdownButton<ComplaintStatus>(
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      value: statusval,
                      hint: const Text(
                        '  Select Status',
                        style: TextStyle(color: Colors.black),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      items: Compstatus.map((ComplaintStatus Compstatusval) {
                        return DropdownMenuItem<ComplaintStatus>(
                          value: Compstatusval,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Compstatusval.name!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (ComplaintStatus? val) {
                        dropDownState(() {
                          setState(() {
                            _dropDownValue2 = val!.id!;
                            statusval = val;
                          });
                        });
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return DropdownButton<SERVICEACTION>(
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      value: serviceloc,
                      hint: const Text(
                        '  Select Service location',
                        style: TextStyle(color: Colors.black),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      items: servieloctiondropdwn
                          .map((SERVICEACTION servicelocval) {
                        return DropdownMenuItem<SERVICEACTION>(
                          value: servicelocval,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              servicelocval.nAME!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (SERVICEACTION? val) {
                        dropDownState(() {
                          setState(() {
                            _dropDownValue3 = val!.iD!;
                            serviceloc = val;
                          });
                        });
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return DropdownButton<SERVICEACTION>(
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      value: defectcode,
                      hint: const Text(
                        '  Select defected-type',
                        style: TextStyle(color: Colors.black),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      items: defectypedropdown.map((SERVICEACTION defectcode) {
                        return DropdownMenuItem<SERVICEACTION>(
                          value: defectcode,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              defectcode.nAME!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (SERVICEACTION? val) {
                        dropDownState(() {
                          setState(() {
                            _dropDownValue4 = val!.iD!;
                            defectcode = val;
                          });
                        });
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return DropdownButton<SERVICEACTION>(
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      value: defectcode,
                      hint: const Text(
                        '  Select call category',
                        style: TextStyle(color: Colors.black),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      items: callcatdropdown.map((SERVICEACTION callcode) {
                        return DropdownMenuItem<SERVICEACTION>(
                          value: callcode,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              callcode.nAME!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (SERVICEACTION? val) {
                        dropDownState(() {
                          setState(() {
                            _dropDownValue5 = val!.iD!;
                            callcode = val;
                          });
                        });
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        CupertinoIcons.pencil,
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Signature',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.thumb_up_alt_outlined,
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'FeedBack(Remark)',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.thumb_up_alt_outlined,
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Tech Remark',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.thumb_up_alt_outlined,
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Happy Code',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
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
