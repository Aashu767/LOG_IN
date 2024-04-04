// ignore_for_file: camel_case_types, unused_element, non_constant_identifier_names, prefer_final_fields, file_names, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, unrelated_type_equality_checks, must_be_immutable, use_super_parameters, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
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
      debugPrint("reuseris${res.body}");
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
      debugPrint("reis${res.body}");
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
      debugPrint("reis${res.body}");
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
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: const Text('COMPLAINTS'),
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 17),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Card(
                    margin: const EdgeInsets.all(16),
                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color.fromRGBO(230, 230, 250, 1),
                              Colors.white,
                              Color.fromRGBO(230, 230, 250, 1)
                            ]),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichTextWidget(
                                title: 'Complaint No:',
                                value: '${complaintlist.first.complaintNo}'),
                            RichTextWidget(
                                title: 'Customer_Name : ',
                                value: '${complaintlist.first.customerName}'),
                            RichTextWidget(
                                title: 'Mobile No : ',
                                value: '${complaintlist.first.mobileNo}'),
                            RichTextWidget(
                                title: 'Address : ',
                                value: '${complaintlist.first.address}'),
                            RichTextWidget(
                                title: 'zone : ',
                                value: '${complaintlist.first.zone}'),
                            RichTextWidget(
                                title: 'Problem : ',
                                value: '${complaintlist.first.problem}'),
                            RichTextWidget(
                                title: 'Problem_Since : ',
                                value: '${complaintlist.first.problemSince}'),
                            RichTextWidget(
                                title: 'Nature : ',
                                value: '${complaintlist.first.nature}'),
                            RichTextWidget(
                                title: 'type : ',
                                value: '${complaintlist.first.type}'),
                            RichTextWidget(
                                title: 'KNo : ',
                                value: '${complaintlist.first.kNo}'),
                            RichTextWidget(
                                title: 'eMail : ',
                                value: '${complaintlist.first.eMail}'),
                            RichTextWidget(
                                title: 'PinCode : ',
                                value: '${complaintlist.first.pinCode}'),
                            RichTextWidget(
                                title: 'MrCode : ',
                                value: '${complaintlist.first.mrCode}'),
                            RichTextWidget(
                                title: 'Colony : ',
                                value: '${complaintlist.first.colony}'),
                            RichTextWidget(
                                title: 'AREA : ',
                                value: '${complaintlist.first.aREA}'),
                            RichTextWidget(
                                title: 'Status : ',
                                value: '${complaintlist.first.status}'),
                            RichTextWidget(
                                title: 'ASSIGN_TO_Name : ',
                                value: '${complaintlist.first.aSSIGNTOName}'),
                            RichTextWidget(
                                title: 'Assign_To : ',
                                value: '${complaintlist.first.assignTo}'),
                            RichTextWidget(
                                title: 'Registration_Date : ',
                                value:
                                    '${complaintlist.first.registrationDate}'),
                            RichTextWidget(
                                title: 'Completion_Date : ',
                                value: '${complaintlist.first.completionDate}'),
                            RichTextWidget(
                                title: 'ButtonDisplay : ',
                                value: '${complaintlist.first.buttonDisplay}'),
                            const SizedBox(
                              height: 55,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.yellow)),
                                      onPressed: () async {
                                        showAlertDialog(context);
                                      },
                                      child: const Text(
                                        "Assign To",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.yellow)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const comp_update()));
                                      },
                                      child: const Text(
                                        "UPDATE",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.yellow)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const payment()));
                                      },
                                      child: const Text(
                                        "Add Payment",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
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
          backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
      child: const Text("ASSIGN",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          )),
      onPressed: () {
        Navigator.pop(context);
        Assigntoupdate();
      },
    );
    Widget CANCELButton = TextButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("CANCEL",
          style: TextStyle(
            color: Colors.black,
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
                decoration: BoxDecoration(border: Border.all()),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'Comp No.:',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${complaintlist.first.complaintNo}",
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
              decoration: BoxDecoration(border: Border.all()),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter dropDownState) {
                  return DropdownButton<UserList>(
                    value: userval,
                    //value: userlist1,
                    hint: const Text(
                      '   Select to Assign',
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
                        child: Text(
                          user.eMPLNAME!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (UserList? val) {
                      dropDownState(() {
                        setState(() {
                          userlist1 = val!.eMPLID!;
                          userval = val;
                          if (kDebugMode) {
                            print("Vlalll${val.eMPLID} $userlist1");
                          }
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
      padding: const EdgeInsets.all(6.0),
      child: RichText(
        text: TextSpan(
            text: title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
      ),
    );
  }
}