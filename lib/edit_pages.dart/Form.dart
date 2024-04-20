// ignore_for_file: camel_case_types, unused_element, non_constant_identifier_names, prefer_final_fields, file_names, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, unrelated_type_equality_checks, must_be_immutable, use_super_parameters, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:log_in/edit_pages.dart/comp_update.dart';
import 'package:log_in/models/form_model.dart';
import 'package:http/http.dart' as http;
import 'package:log_in/models/subordinate_model.dart';
import 'package:log_in/edit_pages.dart/payment.dart';
import 'package:log_in/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

class Form_page extends StatefulWidget {
  String compno;
  Form_page({Key? key, required this.compno}) : super(key: key);
  @override
  State<Form_page> createState() => _Form_pageState();
}

class _Form_pageState extends State<Form_page> {
  bool isLoading = true;
  List<ComplaintDetail> complaintlist = [];
  List<UserList> userlist = [];
  String userlist1 = "";
  UserList? userval;

  @override
  void initState() {
    super.initState();
    fetchlistApi();
    fetchAssignApi();
  }

  fetchAssignApi() async {
    var staffId = await UserSecureStorage().getStaffId();
    var body = {
      "USER_ID": staffId,
    };
    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_All_Bind_subordinate"),
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
      var userliststring = data['string'];
      userliststring = userliststring.toString().replaceAll("\\r\\\\n", "\n");
      var userobject = json.decode(userliststring.toString());
      var userlistobject = userobject['UserList'];
      Iterable l = userlistobject;

      setState(() {
        userlist = l.map((data) => UserList.fromJson(data)).toList();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  fetchlistApi() async {
    var staffId = await UserSecureStorage().getStaffId();
    var body = {
      "Complaint_No": widget.compno,
      "Assign_User_ID": staffId,
    };
    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_Complaint_BasedOnComplaintNo_SR"),
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
      var complliststring = data['string'];
      complliststring = complliststring.toString().replaceAll("\\r\\\\n", "\n");
      var complobject = json.decode(complliststring.toString());
      complobject = complobject['Complaint_Detail'];
      Iterable l = complobject;
      setState(() {
        complaintlist =
            l.map((data) => ComplaintDetail.fromJson(data)).toList();
        isLoading = false;
      });
    }
  }

  Assigntoupdate() async {
    var body = {
      "Complaint_No": widget.compno,
      "Assign_USER_ID": userlist1,
    };
    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/WS_UPdate_Complaint_Assign"),
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
      var complliststring = data['string'];
      complliststring = complliststring.toString().replaceAll("\\r\\\\n", "\n");
      var response = data['string'];
      if (response == "Data Update Successfully.") {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Assigned Successfully")));
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
          backgroundColor: const Color(0xffFF9800),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          title: const Text('COMPLAINTS'),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Card(
                    margin: const EdgeInsets.all(16),
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10.0,
                                      right: 10.0,
                                      left: 20.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Complaint No'),
                                        Text('Customer_Name '),
                                        Text('Mobile No.'),
                                        Text('Address '),
                                        Text('Zone '),
                                        Text('Problem '),
                                        Text('Problem_since '),
                                        Text('Nature '),
                                        Text('Type '),
                                        Text('kno '),
                                        Text('Email '),
                                        Text('PinCode '),
                                        Text('MrCode '),
                                        Text('Colony '),
                                        Text('Area '),
                                        Text('Status '),
                                        Text('Assign_To_Name '),
                                        Text('Assign_To '),
                                        Text('Registration Date '),
                                        Text('Completion Date '),
                                        Text('Button Display '),
                                      ]),
                                ),
                                const Column(
                                  children: [
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                    Text(":"),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${complaintlist.first.complaintNo}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.customerName}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.mobileNo}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.address}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.zone}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.problem}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.problemSince}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.nature}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.type}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.kNo}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.eMail}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.pinCode}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.mrCode}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.colony}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.aREA}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.status}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.aSSIGNTOName}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.assignTo}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.registrationDate}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.completionDate}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${complaintlist.first.buttonDisplay}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showAlertDialog(context);
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFF9800),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Assign To ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => comp_update(
                                                      compno: widget.compno,
                                                    )));
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFF9800),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Update',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const payment()));
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFF9800),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Add Payment',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            )
                          ]),
                    )),
              ));
  }

  showAlertDialog(BuildContext context) async {
    Widget ASSIGNButton = TextButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
        Color(0xffFF9800),
      )),
      child: const Text("ASSIGN",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          )),
      onPressed: () {
        Navigator.pop(context);
        Assigntoupdate();
      },
    );
    const SizedBox(
      width: 25,
    );
    Widget CANCELButton = TextButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
        Color(0xffFF9800),
      )),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("CANCEL",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          )),
    );

    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      scrollable: true,
      title: const Center(
        child: Text("Assign Complaint",
            style: TextStyle(
              fontSize: 18,
            )),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'Comp No  :',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.compno,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ]))),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter dropDownState) {
                  return DropdownButton<UserList>(
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    value: userval,
                    hint: const Text(
                      '  Select to Assign',
                      style: TextStyle(color: Colors.black),
                    ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    items: userlist.map((UserList user) {
                      return DropdownMenuItem<UserList>(
                        value: user,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            user.eMPLNAME!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (UserList? val) {
                      dropDownState(() {
                        setState(() {
                          userlist1 = val!.eMPLID!;
                          userval = val;
                        });
                      });
                    },
                  );
                },
              ),
            ),
          ],
        )),
      ),
      actions: [
        ASSIGNButton,
        CANCELButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

TextStyle tstyle() {
  return const TextStyle(
      color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold);
}

class RichTextWidget extends StatelessWidget {
  String title, value;
  RichTextWidget({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: RichText(
        text: TextSpan(
            text: title,
            style: const TextStyle(
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              )
            ]),
      ),
    );
  }
}
