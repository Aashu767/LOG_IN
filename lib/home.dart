// ignore_for_file: use_key_in_widget_constructors, avoid_print, unused_element

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log_in/complaint.dart';
import 'package:log_in/dashbord.dart';

// ignore: must_be_immutable, camel_case_types
class home extends StatelessWidget {
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
                context, MaterialPageRoute(builder: (_) =>  dashboard()));
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

class Items {
  String title;
  String img;

  Items({
    required this.title,
    required this.img,
  });
}
