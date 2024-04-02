// ignore_for_file: camel_case_types, avoid_print, unnecessary_new, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log_in/attendence_data.dart/checkin.dart';
import 'package:log_in/attendence_data.dart/checkout.dart';
import 'package:log_in/attendence_data.dart/feedback.dart';
import 'package:log_in/attendence_data.dart/leave.dart';

class attandance extends StatefulWidget {
  const attandance({super.key});

  @override
  State<attandance> createState() => _attandanceState();
}

class _attandanceState extends State<attandance> {
  void tapped(int index, BuildContext context) {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const check_in()));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const check_out()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const leave()));
    } else if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const feedback()));
    }
  }

  Items item1 = new Items(
    title: "Day Check IN",
    event: "",
    img: 'assets/image/check-in.png',
  );

  Items item2 = new Items(
    title: "Day Check OUT",
    event: "",
    img: 'assets/image/check-out.png',
  );

  Items item3 = new Items(
    title: "Leave Request",
    event: "",
    img: 'assets/image/schedule.png',
  );

  Items item4 = new Items(
    title: "Day FeedBack",
    event: "",
    img: 'assets/image/feedback.png',
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
      item3,
      item4,
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text('Attendance'),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 17),
      ),
      body: Flexible(
        child: GridView.count(
          childAspectRatio: 3 / 2,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            int index = myList.indexOf(data);
            return GestureDetector(
              onTap: () {
                tapped(index, context);
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
                  children: <Widget>[
                    Image.asset(data.img, width: 42),
                    const SizedBox(height: 14),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
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
  String event;
  String img;

  Items({
    required this.title,
    required this.event,
    required this.img,
  });
}
