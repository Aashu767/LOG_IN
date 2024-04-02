//  ignore_for_file: camel_case_types, sort_child_properties_last, must_be_immutable, unnecessary_new, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, avoid_web_libraries_in_flutter, unused_element, unnecessary_null_comparison, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log_in/Authentication/login.dart';
import 'package:log_in/All_MENU.dart/Zone.dart';
import 'package:log_in/models/menu_model.dart';
import 'search_complaints.dart';
import 'package:log_in/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'attandance.dart';

class dashboard extends StatefulWidget {
  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  bool isLoading = true;
  List<MenuDetails> menulist = [];
  void tapped(int index, BuildContext context) {}
  final List<String> images = [
    'assets/image/complaints.png',
    'assets/image/overdue.png',
    'assets/image/today_overdue.png',
    'assets/image/completed.png',
    'assets/image/pending.png',
    'assets/image/search_com.png',
    'assets/image/attandance.png',
  ];

  @override
  void initState() {
    super.initState();
    fetchmenuApi();
  }

  fetchmenuApi() async {
    var t_code = await UserSecureStorage().gettcode();
    var staffId = await UserSecureStorage().getStaffId();
    print("staffId$staffId");
    var body = {
      "UserID": staffId,
      "dt1": "0",
      "dt2": "0",
    };
    var res = await http.post(
        Uri.parse(
            'http://140.238.162.89/ServiceWebAPI/Service.asmx/Get_All_MenuLinks_SR'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: body);

    var bodyIs = res.body;
    var statusCode = res.statusCode;
    if (statusCode == 200) {
      debugPrint("reis${res.body}");
      Xml2Json xml2Json = Xml2Json();
      xml2Json.parse(bodyIs);
      var jsonString = xml2Json.toParker();
      var data = jsonDecode(jsonString);
      var menuliststring = data['string'];
      menuliststring = menuliststring.toString().replaceAll("\\r\\\\n", "\n");
      var menuobject = json.decode(menuliststring.toString());
      var menulistobject = menuobject['Menu_Details'];
      Iterable l = menulistobject;
      setState(() {
        menulist = l.map((data) => MenuDetails.fromJson(data)).toList();
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
        backgroundColor: Colors.white,
        title: const Text('DASHBOARD'),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 17),
        actions: [
          Row(
            children: [
              const Text(
                'DATE FILTER',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              IconButton(
                onPressed: () async => {
                  await FlutterSecureStorage().deleteAll(),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Login())),
                },
                icon: const Icon(
                  Icons.power_settings_new,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.count(
              childAspectRatio: 3 / 2,
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              children: menulist.map((data) {
                int index = menulist.indexOf(data);
                return GestureDetector(
                  onTap: () => {
                    if (data.menuName == "Search Complaints")
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Search_complaints()))
                      }
                    else if (data.menuName == "Attendance")
                      {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => attandance()))
                      }
                    else
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => zone(
                                      menuid: data.menuId.toString(),
                                    )))
                      },
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
                        // const SizedBox(height: 8),
                        Text(
                          "${data.menuName} ",
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
