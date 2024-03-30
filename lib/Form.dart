// ignore_for_file: camel_case_types, unused_element, non_constant_identifier_names, prefer_final_fields, file_names, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, unrelated_type_equality_checks, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:log_in/comp_update.dart';
import 'package:log_in/complaint.dart';
import 'package:log_in/models/form_model.dart';
import 'package:http/http.dart' as http;
import 'package:log_in/models/subordinate_model.dart';
import 'package:log_in/payment.dart';
import 'package:xml2json/xml2json.dart';

class Form_page extends StatefulWidget {
  String compno;
  Form_page({super.key, required this.compno});
  @override
  State<Form_page> createState() => _Form_pageState();
}

class _Form_pageState extends State<Form_page> {
  bool isLoading = true;
  List<ComplaintDetail> complaintlist = [];
  List<UserList> userlist = [];
  String userlist1 = "";

  @override
  void initState() {
    super.initState();
    fetchlistApi();
    fetchAssignApi();
  }

  fetchAssignApi() async {
    var body = {
      "USER_ID": "1192",
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
      debugPrint("reis${res.body}");
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(bodyIs);
      var jsonString = xml2json.toParker();
      var data = jsonDecode(jsonString);
      var userliststring = data['string'];
      // var userliststring =
      userliststring.toString().replaceAll("\\r\\\\n", "\n");
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
    var body = {
      "Complaint_No": "2403220003",
      "Assign_User_ID": "1192",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          title: const Text('COMPLAINTS'),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Card(
                    margin: const EdgeInsets.all(16),
                    elevation: 10,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'ComplaintNo: ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${complaintlist.first.complaintNo}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Customer_Name: ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${complaintlist.first.customerName}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Mobile No: ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.mobileNo}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Address : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.address}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'zone : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.zone}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Problem : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.problem}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Problem_Since: ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${complaintlist.first.problemSince}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Nature : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.nature}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'type : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.type}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'KNo : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.kNo}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'eMail : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.eMail}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'PinCode : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.pinCode}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'MrCode : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.mrCode}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Colony : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.colony}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'AREA : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.aREA}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Status : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.status}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'ASSIGN_TO_Name : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${complaintlist.first.aSSIGNTOName}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Assign_To : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${complaintlist.first.assignTo}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Registration_Date : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${complaintlist.first.registrationDate}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Completion_Date : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${complaintlist.first.completionDate}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'ButtonDisplay : ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${complaintlist.first.buttonDisplay}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        )),
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
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
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.yellow)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const comp_update()));
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
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.yellow)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const payment()));
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
                    ])),
              ));
  }

  showAlertDialog(BuildContext context) async {
    Widget ASSIGNButton = TextButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
      child: const Text("ASSIGN",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Complaints(
                      zoneid: "",
                      menuid: "",
                    )));
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
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
    );

    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      scrollable: true,
      title: const Center(
        child: Text("Assign Complaint",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: Column(
          children: [
            Container(
                decoration: mydecoration(),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'Comp No.:',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${complaintlist.first.complaintNo}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]))),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: mydecoration(),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter dropDownState) {
                  return DropdownButton<String>(
                    hint: const Text(' Select to Assign'),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    items: userlist.map((UserList user) {
                      return DropdownMenuItem<String>(
                        value: user.eMPLNAME,
                        child: Text(
                          user.eMPLNAME!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? val) {
                      dropDownState(() {
                        userlist1 = val!;
                      });
                    },
                  );
                },
              ),
            ),
            // Container(
            //   decoration: mydecoration(),
            //   child: StatefulBuilder(
            //       builder: (BuildContext context, StateSetter dropDownState) {
            //     return DropdownButton(
            //       padding: const EdgeInsets.symmetric(horizontal: 8),
            //       hint: userlist1 == ""
            //           ? const Text('Select To Assign')
            //           : Text(
            //               "${userlist.first.eMPLNAME}",
            //               style: const TextStyle(
            //                   color: Colors.black,
            //                   fontSize: 17,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //       isExpanded: true,
            //       iconSize: 30.0,
            //       style: const TextStyle(
            //           color: Colors.blue,
            //           fontSize: 17,
            //           fontWeight: FontWeight.bold),
            //       items: [userlist.first.eMPLNAME].map(
            //         (val) {
            //           return DropdownMenuItem<String>(
            //             value: "${userlist.first.eMPLNAME}",
            //             child: Text("${userlist.first.eMPLNAME}"),
            //           );
            //         },
            //       ).toList(),
            //       onChanged: (val) {
            //         dropDownState(
            //           () {
            //             userlist = val! as List<UserList>;
            //           },
            //         );
            //       },
            //     );
            //   }),
            // ),
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

BoxDecoration mydecoration() {
  return BoxDecoration(
    border:
        Border.all(style: BorderStyle.solid, color: Colors.black, width: 2.0),
  );
}
