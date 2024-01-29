// ignore_for_file: camel_case_types, avoid_print, unnecessary_new, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log_in/checkin.dart';
import 'package:log_in/checkout.dart';
import 'package:log_in/feedback.dart';
import 'package:log_in/leave.dart';


class attandance extends StatelessWidget {
  attandance({super.key});

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
    var color = 0xFF2979FF;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text('Attendance'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
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
