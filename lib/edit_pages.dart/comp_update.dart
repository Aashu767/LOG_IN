// ignore_for_file: camel_case_types, unnecessary_null_comparison, avoid_unnecessary_containers, unused_element, avoid_print, unused_field, must_be_immutable, use_super_parameters, non_constant_identifier_names, unnecessary_string_interpolations, unrelated_type_equality_checks, library_private_types_in_public_api, sized_box_for_whitespace

import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:log_in/edit_pages.dart/signature.dart';
import 'package:log_in/models/All_dropdown_model.dart';
import 'package:log_in/models/itemModel.dart';
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
  String _itemcodeValue = "";
  String _itemnameValue = "";
  String _actiontakenValue = "";
  String _compstatusValue = "";
  String _servicelocValue = "";
  String _defecttypeValue = "";
  String _callcodeValue = "";
  String _redressalValue6 = "";
  String selectedDate = 'Tap to select date';
  late File _image;
  final picker = ImagePicker();
  List<ItemDetails> itemdetail = [];
  List<ServiceAction> serviceact = [];
  List<SERVICEACTION> servieloctiondropdwn = [];
  List<SERVICEACTION> complaintstatusdropdwn = [];
  List<SERVICEACTION> redressaldropdown = [];
  List<SERVICEACTION> defectypedropdown = [];
  List<SERVICEACTION> callcatdropdown = [];
  TextEditingController Qty = TextEditingController();
  TextEditingController Rate = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController dateController1 = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController actualController = TextEditingController();
  TextEditingController actualcloserController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  TextEditingController techremarkController = TextEditingController();
  TextEditingController happycodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<AddedItem> addedItems = [];
  List<itemModel> addedItemsVal = [];
  bool isLoading = true;
  ServiceAction? actionval;
  ItemDetails? itemval;
  SERVICEACTION? complaintstatus;
  SERVICEACTION? serviceloc;
  SERVICEACTION? defectcode;
  SERVICEACTION? callcode;
  SERVICEACTION? redressal;
  File? _imgFile;
  String img64 = "";
  Uint8List? signatureImage;
  TimeOfDay? _selectedTime;
  late DateFormat _timeFormat;

  @override
  void initState() {
    super.initState();
    DDUApi();
    fetchservice();
    _timeFormat = DateFormat('hh:mm a');
  }

  String uint8ListTob64(Uint8List uint8list) {
    String base64String = base64Encode(uint8list);
    return base64String;
  }

  saveupdatedata() async {
    var signimg64 = uint8ListTob64(signatureImage!);
    var staffId = await UserSecureStorage().getStaffId();
    var body = {
      "Complaint_No": widget.compno,
      "Actual_Problem": actualController.text,
      "Action_Taken": _actiontakenValue,
      "Visit_Date": dateController.text,
      "Action_Date": dateController1.text,
      "Action_Time": timeController.text,
      "Status": _compstatusValue,
      "Signature_Image": signimg64,
      "Picture_Taken": img64,
      "Item_JSON": addedItemsVal.toString(),
      "Actual_Closure": actualcloserController.text,
      "Customer_FeedBack": feedbackController.text,
      "User_Id": staffId,
      "REDRESSAL_STATUS": _redressalValue6,
      "Tech_Remark": techremarkController.text,
      "Service_Location": _servicelocValue,
      "Happy_Code": happycodeController.text,
      "DefectType": _defecttypeValue,
      "CallCatg": _callcodeValue,
    };
    var res = await http.post(
        Uri.parse(
            "http://nds1.nippondata.com/ServiceWebApi/Service.asmx/WS_Update_complaints_SR"),
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
      print("objectupdate$data");
      var valueliststring = data['string'];
      valueliststring = valueliststring.toString().replaceAll("\\r\\\\n", "\n");
      var valueobject = json.decode(valueliststring.toString());
      var valuelistobject = valueobject['SchemeSKU'];
      print("objectupdate$valuelistobject");
      setState(() {
        // saveupdatedata =
        //     l.map((data) => saveupdatedata.fromJson(data)).toList();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
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

      setState(() {
        itemdetail = item.map((data) => ItemDetails.fromJson(data)).toList();
        serviceact =
            service.map((data) => ServiceAction.fromJson(data)).toList();
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
      var compstatuseobject = itemobject['COMPLAINT_STATUS'];
      Iterable compstatus = compstatuseobject;
      var serviceobject = itemobject['SERVICE_LOCATION'];
      Iterable item = serviceobject;
      var deftypelistobject = itemobject['DEFECT_TYPE'];
      Iterable service = deftypelistobject;
      var callcatobject = itemobject['CALL_CATEGORY'];
      Iterable status = callcatobject;
      var redressalobject = itemobject['REDRESSAL_STATUS'];
      Iterable redressalstatus = redressalobject;

      setState(() {
        complaintstatusdropdwn =
            compstatus.map((data) => SERVICEACTION.fromJson(data)).toList();
        servieloctiondropdwn =
            item.map((data) => SERVICEACTION.fromJson(data)).toList();
        defectypedropdown =
            service.map((data) => SERVICEACTION.fromJson(data)).toList();
        callcatdropdown =
            status.map((data) => SERVICEACTION.fromJson(data)).toList();
        redressaldropdown = redressalstatus
            .map((data) => SERVICEACTION.fromJson(data))
            .toList();
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

  _selectDate1(BuildContext context) async {
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        timeController.text = _timeFormat
            .format(DateTime(2022, 1, 1, picked.hour, picked.minute));
      });
    }
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
        title: const Text('Complaints Update'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: SingleChildScrollView(
          child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 10,
        child: Form(
          key: _formKey,
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
                          '   Complaint No  :',
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
                          child: StatefulBuilder(builder: (BuildContext context,
                              StateSetter dropDownState) {
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
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          itemdetail.name!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (ItemDetails? val) {
                                  dropDownState(() {
                                    setState(() {
                                      _itemcodeValue = val!.id!;
                                      _itemnameValue = val.name!;
                                      itemval = val;
                                    });
                                  });
                                });
                          }),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.12,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Colors.transparent),
                              bottom: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: Qty,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: 'Qty',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.black,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Colors.transparent),
                              bottom: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: Rate,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: 'Rate',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (itemval != null &&
                                Qty.text.isNotEmpty &&
                                Rate.text.isNotEmpty) {
                              setState(() {
                                addedItemsVal.add(itemModel(
                                    itemID: _itemcodeValue,
                                    itemName: _itemnameValue,
                                    itemQty: Qty.text,
                                    sTRQCCODE: "",
                                    sTREXCREG: "",
                                    sTRMODVATVLUE: "",
                                    itemRate: Rate.text,
                                    sTRPLCECODE: ""));
                              });
                              Qty.clear();
                              Rate.clear();
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.180,
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
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: addedItemsVal.length,
                        itemBuilder: (context, index) {
                          final item = addedItemsVal[index];
                          return Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide.none,
                                          bottom: BorderSide.none,
                                          left: BorderSide.none,
                                          right: BorderSide(),
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(' ${item.itemName}')),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide.none,
                                          bottom: BorderSide.none,
                                          left: BorderSide.none,
                                          right: BorderSide(),
                                        ),
                                      ),
                                      child: Center(
                                          child: Text('${item.itemQty}')),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide.none,
                                          bottom: BorderSide.none,
                                          left: BorderSide.none,
                                          right: BorderSide(),
                                        ),
                                      ),
                                      child: Center(
                                          child: Text('${item.itemRate}')),
                                    ),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.13,
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
                                                addedItemsVal.removeAt(index);
                                              });
                                            },
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.only(left: 8, top: 11, bottom: 5),
                    child: TextField(
                      controller: actualController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]')),
                      ],
                      decoration: const InputDecoration(
                        hintText: 'Actual Problem',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
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
                              _actiontakenValue = val!.id!;
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
                                  ? ' Visit Date:'
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.only(left: 8, top: 11, bottom: 5),
                    child: TextField(
                      controller: actualcloserController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]')),
                      ],
                      decoration: const InputDecoration(
                        hintText: 'Actual Closer',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              _selectdate1(context);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Center(
                                child: Text(
                                  dateController1.text == ""
                                      ? ' Action Date:'
                                      : dateController1.text,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _selectTime(context);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Center(
                                  child: Text(
                                timeController.text.isEmpty
                                    ? 'Action Time:'
                                    : timeController.text,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        value: complaintstatus,
                        hint: const Text(
                          '  Select Status',
                          style: TextStyle(color: Colors.black),
                        ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        items: complaintstatusdropdwn
                            .map((SERVICEACTION complstatusval) {
                          return DropdownMenuItem<SERVICEACTION>(
                            value: complstatusval,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                complstatusval.nAME!,
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
                              _compstatusValue = val!.iD!;
                              complaintstatus = val;
                            });
                          });
                        },
                      );
                    }),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  if (complaintstatus?.nAME == 'COMPLETED')
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
                          value: redressal,
                          hint: const Text(
                            '  Select Redressal Status',
                            style: TextStyle(color: Colors.black),
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          items: redressaldropdown
                              .map((SERVICEACTION redressalval) {
                            return DropdownMenuItem<SERVICEACTION>(
                              value: redressalval,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  redressalval.nAME!,
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
                                _redressalValue6 = val!.iD!;
                                redressal = val;
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
                              _servicelocValue = val!.iD!;
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
                        items:
                            defectypedropdown.map((SERVICEACTION defectcode) {
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
                              _defecttypeValue = val!.iD!;
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
                        value: callcode,
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
                              _callcodeValue = val!.iD!;
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
                  InkWell(
                    onTap: () async {
                      signatureImage = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignatureScreen()));

                      setState(() {});
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        Image.asset(
                          "assets/image/pen.png",
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        signatureImage == null
                            ? const Text(
                                'Signature',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            : Image.memory(
                                signatureImage!,
                              ),
                      ]),
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        Image.asset("assets/image/camera.png"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
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
                    child: Row(
                      children: [
                        Image.asset("assets/image/feedback_remark.png"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Expanded(
                          child: TextField(
                            controller: feedbackController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z\s]')),
                            ],
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'FeedBack(Remark)',
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
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
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Image.asset("assets/image/like_thumb.png"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Expanded(
                          child: TextField(
                            controller: techremarkController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z\s]')),
                            ],
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'Tech Remark',
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
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
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Image.asset("assets/image/like_thumb.png"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Expanded(
                          child: TextField(
                            controller: happycodeController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Happy Code',
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                      saveupdatedata();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => Complaints(
                      //               zoneid: "",
                      //               menuid: "",
                      //             )));
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
