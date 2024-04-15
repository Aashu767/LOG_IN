// ignore_for_file: use_key_in_widget_constructors, avoid_print, unused_element, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_local_variable, file_names, must_be_immutable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log_in/All_MENU.dart/dashbord.dart';
import 'package:log_in/models/zone_model.dart';
import 'package:log_in/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

import '../edit_pages.dart/complaint.dart';

class zone extends StatefulWidget {
  String menuid;
  zone({super.key, required this.menuid});
  @override
  State<zone> createState() => _zoneState();
}

class _zoneState extends State<zone> {
  bool isLoading = true;
  List<ComplaintsType> zonelist = [];
  final List<String> images = [
    'assets/image/Complaint.png',
    'assets/image/time.png',
    'assets/image/overdue1.png',
    'assets/image/completed1.png',
    'assets/image/pending1.png',
    'assets/image/search1.png',
    'assets/image/attandance1.png',
  ];

  void tapped(int index, BuildContext context) {}

  @override
  void initState() {
    super.initState();
    fetchzoneApi();
  }

  fetchzoneApi() async {
    var t_code = await UserSecureStorage().gettcode();
    var staffId = await UserSecureStorage().getStaffId();
    var body = {
      "MenuID": widget.menuid,
      "UserID": staffId,
      "dt1": "0",
      "dt2": "0",
    };
    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_All_Zones_SR"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
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
      var zoneliststring = data['string'];
      zoneliststring = zoneliststring.toString().replaceAll("\\r\\\\n", "\n");
      var zoneobject = json.decode(zoneliststring.toString());
      var zonelistobject = zoneobject['Complaints_Type'];
      Iterable l = zonelistobject;
      setState(() {
        zonelist = l.map((data) => ComplaintsType.fromJson(data)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF9FAFF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => dashboard()));
            },
          ),
          backgroundColor: const Color(0xffFF9800),
          title: const Text(
            'DISTRICT WISE ACTIVITY',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: zonelist.map((data) {
                  int index = zonelist.indexOf(data);
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.07,
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.grey)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Complaints(
                                        zoneid: data.zoneId!,
                                        menuid: widget.menuid,
                                      )));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              images[index],
                              height: 30,
                              width: 80,
                            ),
                            Text(
                              "${data.zoneName} ",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "[${data.count}]",
                                    style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ));
  }
}
