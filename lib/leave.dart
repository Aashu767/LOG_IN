// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class leave extends StatelessWidget {
  const leave({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text('Leave Request'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Text(
                "Reason Of Leave",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Reason For Leave',
                  ),
                )),
            const Row(
              children: [
                Expanded(
                    child: Divider(
                  thickness: 3,
                  indent: 25,
                  endIndent: 25,
                  color: Colors.black,
                  height: 5,
                )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Text(
                "No Of Days",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter No Of Days',
                  ),
                )),
            const Row(
              children: [
                Expanded(
                    child: Divider(
                  thickness: 3,
                  indent: 25,
                  endIndent: 25,
                  color: Colors.black,
                  height: 5,
                )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Text(
                "From Date",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Date dd-mm-yy',
                  ),
                )),
            const Row(
              children: [
                Expanded(
                    child: Divider(
                  thickness: 3,
                  indent: 25,
                  endIndent: 25,
                  color: Colors.black,
                  height: 5,
                )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Text(
                "To Date",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Date dd-mm-yy',
                  ),
                )),
            const Row(
              children: [
                Expanded(
                    child: Divider(
                  thickness: 3,
                  indent: 25,
                  endIndent: 25,
                  color: Colors.black,
                  height: 5,
                )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Text(
                "Remarks",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Remarks',
                  ),
                )),
            const Row(
              children: [
                Expanded(
                    child: Divider(
                  thickness: 3,
                  indent: 25,
                  endIndent: 25,
                  color: Colors.black,
                  height: 5,
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
                onPressed: () {},
                child: const Text(
                  "Save",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
                onPressed: () {},
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              )
            ]),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
