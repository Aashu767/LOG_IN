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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => dashboard()));
          },
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'DISTRICT WISE ACTIVITY',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              childAspectRatio: 3 / 2,
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              children: zonelist.map((data) {
                int index = zonelist.indexOf(data);
                return GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Complaints(
                                  zoneid: data.zoneId!,
                                  menuid: widget.menuid,
                                )))
                  },
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          images[index],
                          height: 30,
                          width: 80,
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Text(
                            "${data.zoneName}",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "[${data.count}]",
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
