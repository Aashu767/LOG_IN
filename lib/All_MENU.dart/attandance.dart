// ignore_for_file: camel_case_types, avoid_print, unnecessary_new, must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log_in/attendance_data.dart/checkin.dart';
import 'package:log_in/attendance_data.dart/checkout.dart';
import 'package:log_in/attendance_data.dart/feedback.dart';
import 'package:log_in/attendance_data.dart/leave.dart';

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
    img: 'assets/image/feedback1.png',
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
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          itemCount: myList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: InkWell(
                onTap: () {
                  tapped(index, context);
                },
                child: PhysicalModel(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  elevation: 5,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        PhysicalModel(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.16,
                              height: MediaQuery.sizeOf(context).height * 0.07,
                              child: Center(
                                child: Image.asset(
                                  myList[index].img,
                                  height: 35,
                                  width: 35,
                                ),
                              )),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          myList[index].title,
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              color: Colors.black,
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
          },
        ));
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
