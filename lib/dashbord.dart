//  ignore_for_file: camel_case_types, sort_child_properties_last, must_be_immutable, unnecessary_new, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log_in/Authentication/login.dart';
import 'package:log_in/attandance.dart';
import 'package:log_in/home.dart';


// ignore: use_key_in_widget_constructors
class dashboard extends StatelessWidget {
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
    subtitle: "",
    event: "",
    img: 'assets/image/cp45.jpg',
  );

  Items item2 = new Items(
    title: "OVERDUE",
    subtitle: "",
    event: "",
    img: 'assets/image/food.png',
  );
  Items item3 = new Items(
    title: "TODAY OVERDUE",
    subtitle: "",
    event: "",
    img: 'assets/image/map.png',
  );
  Items item4 = new Items(
    title: "COMPLETED",
    subtitle: "",
    event: "",
    img: 'assets/image/festival.png',
  );
  Items item5 = new Items(
    title: "PENDING",
    subtitle: "",
    event: "",
    img: 'assets/image/todo.png',
  );
  Items item6 = new Items(
    title: "SEARCH COMPLAINTS",
    subtitle: "",
    event: "",
    img: 'assets/image/setting.png',
  );
  Items item7 = new Items(
    title: "ATTANDENCE",
    subtitle: "",
    event: "",
    img: 'assets/image/notification.png',
  );
  Items item8 = new Items(
    title: "FEEDBACK",
    subtitle: "",
    event: "",
    img: 'assets/image/7443.png',
  );

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
      item8,
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
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      data.event,
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
  String subtitle;
  String event;
  String img;

  Items({
    required this.title,
    required this.subtitle,
    required this.event,
    required this.img,
  });
}
