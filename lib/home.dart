// ignore_for_file: use_key_in_widget_constructors, avoid_print, unused_element, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log_in/complaint.dart';
import 'package:log_in/dashbord.dart';
import 'package:log_in/models/zone_model.dart';
// import 'package:log_in/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool isLoading = true;
  get zoneId => null;

  void tapped(int index, BuildContext context) {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const Complaints()));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const Complaints()));
    }
  }

  Items item1 = Items(
    title: "ANANTAPUR",
    img: 'assets/image/cp45.jpg',
  );

  Items item2 = Items(
    title: "DELHI",
    img: 'assets/image/food.png',
  );

  Future<void> fetchDataFromApi(
      String Zone_Id, String Zone_Name, String Count) async {
    fetchDataFromApi(Zone_Id, Zone_Name, Count);
  }

  data(zoneId, zoneName, count) async {
    setState(() {
      isLoading = true;
    });

    List<zonemodel1> zoneId = [];

    @override
    void initState() {
      super.initState();
    }

    Future<void> fetchzoneDetails() async {
      try {
        var response = await http.post(
            Uri.parse(
                "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_All_Zones_SR"),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: {
              "UserID": "1192"
            });
        var bodyIs = response.body;
        print("resss$response");
        if (response.statusCode == 200) {
          Xml2Json xml2Json = Xml2Json();
          xml2Json.parse(bodyIs);
          var jsonString = xml2Json.toParker();
          var data = jsonDecode(jsonString);
          var zonelist = data['Zone_Id'];
          debugPrint("data is ${data['Menu_Details']}");
          final Map<String, dynamic> responseData = json.decode(response.body);
          final List<dynamic> zoneId = responseData['Complaints_Type'];
          setState(() {
            print('hello1');
          });
        } else {
          throw Exception('Failed to load menu details');
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_All_Zones_SR"),
        body: {
          "UserID": "1192",
          "MenuID": "10009",
        });
    var bodyIs = res.body;
    print(bodyIs);
    var statusCode = res.statusCode;
    var response;
    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode(response.body);
      });

      debugPrint(statusCode.toString());
      debugPrint("res is ${res.body}");
      Xml2Json xml2Json = Xml2Json();
      xml2Json.parse(bodyIs);
      var jsonString = xml2Json.toParker();
      debugPrint("xml2Json is $jsonString");
      var data = jsonDecode(jsonString);
      var staffId = data['string'];
      debugPrint("data is ${data['string']}");
      if (!context.mounted) return;
      if (data['string'] != 'false') {
        return data;
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  // fetchzoneApi() async {
  //   var List = Items;
  //   var t_code = await UserSecureStorage().gettcode();
  //   var body = {
  //     "UserID": "1192",
  //   };
  //   var res = await http.post(
  //       Uri.parse(
  //           'http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_All_Zones_SR'),
  //       headers: {
  //         "Accept": "application/json",
  //         "Content-Type": "application/x-www-form-urlencoded"
  //       },
  //       body: body);

  //   var bodyIs = res.body;
  //   var statusCode = res.statusCode;
  //   if (statusCode == 200) {
  //     debugPrint("reis${res.body}");
  //     Xml2Json xml2Json = Xml2Json();
  //     xml2Json.parse(bodyIs);
  //     var jsonString = xml2Json.toParker();
  //     var data = jsonDecode(jsonString);
  //     var menulistobject = data['Menu_Detail'];
  //     menulistobject = menulistobject.toString().replaceAll("\\r\\\\n", "\n");
  //     var object = json.decode(menulistobject.toString());
  //     print("Iterable$object $menulistobject");
  //     Iterable l = object;

  //     //List<MenuDetails> posts = List<MenuDetails>.from(l.map((model)=> MenuDetails.fromJson(model)));
  //     setState(() {
  //       object.forEach((v) {
  //         menulistobject.add(zonemodel.fromJson(v));
  //       });
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
    ];
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
                  children: <Widget>[
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

@override
Widget build(BuildContext context) {
  throw UnimplementedError();
}

class Items {
  String title;
  String img;

  Items({
    required this.title,
    required this.img,
  });
}
