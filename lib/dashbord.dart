//  ignore_for_file: camel_case_types, sort_child_properties_last, must_be_immutable, unnecessary_new, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, avoid_web_libraries_in_flutter, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log_in/Authentication/login.dart';
import 'package:log_in/attandance.dart';
import 'package:log_in/home.dart';
import 'package:log_in/models/menu_model.dart';
import 'package:log_in/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: use_key_in_widget_constructors
class dashboard extends StatefulWidget {
  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  bool isLoading = true;
  // List<MenuModel> list1 = [];

  get menuId => null;
  void tapped(int index, BuildContext context) {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => home()));
    } else if (index == 1) {
      print("not the two :(");
    } else if (index == 2) {
      print("not the three :(");
    } else if (index == 3) {
      print("not the four :(");
    } else if (index == 4) {
      print("not the five :(");
    } else if (index == 5) {
      print("not the six :(");
    } else if (index == 6) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => attandance()));
    } else if (index == 7) {
      print("not the eight :(");
    }
  }

  Items item1 = new Items(
    title: "ALL COMPLAINTS",
    img: 'assets/image/cp45.jpg',
  );

  Items item2 = new Items(
    title: "OVERDUE",
    img: 'assets/image/food.png',
  );

  Items item3 = new Items(
    title: "TODAY OVERDUE",
    img: 'assets/image/map.png',
  );

  Items item4 = new Items(
    title: "COMPLETED",
    img: 'assets/image/festival.png',
  );

  Items item5 = new Items(
    title: "PENDING",
    img: 'assets/image/todo.png',
  );

  Items item6 = new Items(
    title: "SEARCH\nCOMPLAINTS",
    img: 'assets/image/setting.png',
  );

  Items item7 = new Items(
    title: "ATTANDENCE",
    img: 'assets/image/notification.png',
  );

  Future<void> fetchDataFromApi(
      String Menu_Id, String Menu_Name, String Count) async {
    fetchDataFromApi(Menu_Id, Menu_Name, Count);
  }

  data(menuId, menuname, count) async {
    setState(() {
      isLoading = true;
    });

    // var res = await http.post(
    //     Uri.parse(
    //         "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_All_MenuLinks/"),
    //     body: {
    //       "UserID": "1192",
    //     });
    // var bodyIs = res.body;
    // print(bodyIs);
    // var statusCode = res.statusCode;
    // var response;
    // if (response.statusCode == 200) {
    //   setState(() {
    //     var data = json.decode(response.body);
    //   });

    //   debugPrint(statusCode.toString());
    //   debugPrint("res is ${res.body}");
    //   Xml2Json xml2Json = Xml2Json();
    //   xml2Json.parse(bodyIs);
    //   var jsonString = xml2Json.toParker();
    //   debugPrint("xml2Json is $jsonString");
    //   var data = jsonDecode(jsonString);
    //   var staffId = data['string'];
    //   debugPrint("data is ${data['string']}");
    //   if (!context.mounted) return;
    //   if (data['string'] != 'false') {
    //     return data;
    //   }
    // } else {
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  }

  List<MenuModel> menuDetails = [];

  @override
  void initState() {
    super.initState();
    fetchMenuDetails();
  }

  Future<void> fetchMenuDetails() async {
    try {
      final response = await http.get(Uri.parse(
          'http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_All_MenuLinks'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> menuList = responseData['Menu_Details'];
        setState(() {
          menuDetails =
              menuList.map((menu) => MenuModel.fromJson(menu)).toList();
        });
        fetchDataFromApi() async {
          var List = Items;
          var t_code = await UserSecureStorage().gettcode();
          var body = {
            "UserID": "1192",
          };
          var res = await http.post(
              Uri.parse(
                  'http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_All_MenuLinks'),
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded"
              },
              body: body);

          var bodyIs = res.body;
          var statusCode = res.statusCode;
          if (statusCode == 200) {
            debugPrint("res is  2222${res.body}");
            Xml2Json xml2Json = Xml2Json();
            xml2Json.parse(bodyIs);
            var jsonString = xml2Json.toParker();
            var data = jsonDecode(jsonString);
            var complaintObject = data['string'];
            complaintObject =
                complaintObject.toString().replaceAll("\\r\\\\n", "\n");
            var object = json.decode(complaintObject.toString());
            setState(() {
              object.forEach((v) {
                menuList.add(MenuModel.fromJson(v));
              });
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        }
      } else {
        throw Exception('Failed to load menu details');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
      item7,
    ];
    var color = 0xFF2979FF;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text('DASHBOARD'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        actions: [
          Row(
            children: [
              const Text(
                'DATE FILTER',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              IconButton(
                onPressed: () async => {
                  await FlutterSecureStorage().deleteAll(),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Login())),
                },
                icon: const Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Flexible(
        child: GridView.count(
          childAspectRatio: 1.0,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            int index = myList.indexOf(data);
            return GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(color),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(data.img, width: 42),
                    const SizedBox(height: 14),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => {
                        tapped(index, context),
                      },
                      icon: const Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Items {
  String title;
  String img;

  Items({
    required this.title,
    required this.img,
  });
}
