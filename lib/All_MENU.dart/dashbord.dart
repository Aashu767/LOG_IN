//  ignore_for_file: camel_case_types, sort_child_properties_last, must_be_immutable, unnecessary_new, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, avoid_web_libraries_in_flutter, unused_element, unnecessary_null_comparison, use_key_in_widget_constructors, sized_box_for_whitespace, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:log_in/Authentication/login.dart';
import 'package:log_in/All_MENU.dart/Zone.dart';
import 'package:log_in/models/date_filter_model.dart';
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
  TextEditingController fromdatecontroller = TextEditingController();
  TextEditingController todatecontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController fromdateController = TextEditingController();
  TextEditingController todateController = TextEditingController();
  var staffId;
  void tapped(int index, BuildContext context) {}
  final List<String> images = [
    'assets/image/Complaint.png',
    'assets/image/time.png',
    'assets/image/overdue1.png',
    'assets/image/completed1.png',
    'assets/image/pending1.png',
    'assets/image/search1.png',
    'assets/image/attandance1.png',
  ];
  List<ComplaintsList> datefilterlist = [];

  @override
  void initState() {
    super.initState();
    fetchmenuApi();
    getstaffid();
    date_filterapi();
  }

  date_filterapi() async {
    var body = {
      "SearchString": "2208100002",
      "dt1": fromdateController.text,
      "dt2": todateController.text,
    };

    var res = await http.post(
        Uri.parse(
            "http://nds1.nippondata.com/ServiceWebApi/Service.asmx/Search_ComplaintsListV2"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: body);
    var bodyIs = res.body;
    var statuCode = res.statusCode;
    if (statuCode == 200) {
      debugPrint("reis${res.body}");
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(bodyIs);
      var jsonString = xml2json.toParker();
      var data = jsonDecode(jsonString);
      var compliststring = data['string'];
      compliststring = compliststring.toString().replaceAll("\\r\\\\n", "\n");
      var compobject = json.decode(compliststring.toString());
      var complistobject = compobject['Complaints_List'];
      Iterable l = complistobject;
      setState(() {
        datefilterlist =
            l.map((data) => ComplaintsList.fromJson(data)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String> getstaffid() async {
    staffId = await UserSecureStorage().getStaffId();
    return staffId;
  }

  fetchmenuApi() async {
    var t_code = await UserSecureStorage().gettcode();
    var staffId = await UserSecureStorage().getStaffId();
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
        backgroundColor: Color(0xffF9FAFF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffFF9800),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DashBoard',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    showAlertDialog(context);
                  },
                  child: Text(
                    'Date Filter',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(55.0),
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.06,
              decoration: BoxDecoration(
                  color: Color(0xffF0F4FF),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(5),
              margin: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage('assets/image/Ellipse95.png'),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.10,
                  ),
                  Text(
                    'Hi,',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '$staffId',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.40),
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
            ),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: menulist.map((data) {
                    int index = menulist.indexOf(data);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: PhysicalModel(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height * 0.07,
                          margin: EdgeInsets.only(
                            right: 10,
                          ),
                          child: InkWell(
                            onTap: () {
                              if (data.menuName == "Search Complaints") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Search_complaints()));
                              } else if (data.menuName == "Attendance") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => attandance()));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => zone(
                                              menuid: data.menuId.toString(),
                                            )));
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    PhysicalModel(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      elevation: 5,
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.16,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.07,
                                        child: Image.asset(
                                          images[index],
                                          height: 60,
                                          width: 80,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      "${data.menuName}",
                                      style: GoogleFonts.openSans(
                                        textStyle: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ));
  }

  showAlertDialog(BuildContext context) async {
    Widget DismissButton = TextButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
        Color(0xffFF9800),
      )),
      child: const Text("Dismiss",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          )),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    const SizedBox(
      width: 25,
    );
    Widget submitButton = TextButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
        Color(0xffFF9800),
      )),
      onPressed: () {
        // if (_formKey.currentState != null &&
        //     _formKey.currentState!.validate()) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Please Enter Date')),
        //   );
        // }
        date_filterapi();
      },
      child: const Text("Submit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          )),
    );

    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      scrollable: true,
      title: const Center(
        child: Text("DATE FILTER",
            style: TextStyle(
              fontSize: 18,
            )),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "From Date :",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _fromdate(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Row(children: [
                          Text(
                            fromdateController.text == ""
                                ? ' Select From Date '
                                : fromdateController.text,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "To Date :",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _todate(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Row(children: [
                          Text(
                            todateController.text == ""
                                ? 'Select To Date '
                                : todateController.text,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
      actions: [
        DismissButton,
        submitButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _fromdate(BuildContext context) async {
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
        fromdateController.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  _todate(BuildContext context) async {
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
        todateController.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }
}
