// ignore_for_file: camel_case_types, avoid_print, unnecessary_new, must_be_immutable, avoid_unnecessary_containers

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
    img: 'assets/image/check-in.png',
  );

  Items item2 = new Items(
    title: "Day Check OUT",
    img: 'assets/image/check-out.png',
  );

  Items item3 = new Items(
    title: "Leave Request",
    img: 'assets/image/schedule.png',
  );

  Items item4 = new Items(
    title: "Day FeedBack",
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
      backgroundColor: const Color(0xffF9FAFF),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffFF9800),
        title: const Text('Attendance'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
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
            return InkWell(
              onTap: () {
                tapped(index, context);
              },
              child: PhysicalModel(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                elevation: 5,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(data.img, width: 35),
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
                    ],
                  ),
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
