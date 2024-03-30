// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log_in/edit_pages.dart/complaint.dart';
import 'package:log_in/All_MENU.dart/dashbord.dart';
import 'package:log_in/models/zone_model.dart';
import 'package:xml2json/xml2json.dart';

class completed_task extends StatefulWidget {
  const completed_task({super.key});

  @override
  State<completed_task> createState() => _completed_taskState();
}

class _completed_taskState extends State<completed_task> {
  bool isLoading = true;
  List<ComplaintsType> zonelist = [];

  void tapped(int index, BuildContext context) {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) =>  Complaints(zoneid: "",menuid: "",)));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) =>  Complaints(zoneid: "",menuid: "",)));
    }
  }

  List imgpath = [
    'assets/image/cp45.jpg',
    'assets/image/notification.png',
    'assets/image/food.png',
    'assets/image/map.png',
    'assets/image/festival.png',
    'assets/image/todo.png',
    'assets/image/setting.png',
  ];
  @override
  void initState() {
    super.initState();
    fetchzoneApi();
  }

  fetchzoneApi() async {
    var body = {
      "MenuID": "10005",
      "UserID": "1192",
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
    var color = 0xFF2979FF;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => dashboard()));
          },
        ),
        backgroundColor: Colors.blue,
        title: const Text('DISTRICT WISE ACTIVITY'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        actions: const [
          Row(
            children: [],
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              childAspectRatio: 1.0,
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              children: zonelist.map((data) {
                int index = zonelist.indexOf(data);
                return GestureDetector(
                  onTap: () => {
                    tapped(index, context),
                  },
                  child: Container(
                    height: 20,
                    width: 5,
                    decoration: BoxDecoration(
                      color: Color(color),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Image.asset(data.imgpath, width: 42,),
                            IconButton(
                              onPressed: () => {},
                              icon: const Icon(
                                Icons.arrow_circle_right_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "${data.zoneName}  [${data.count}]",
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
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
