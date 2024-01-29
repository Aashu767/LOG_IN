// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class check_out extends StatelessWidget {
  const check_out({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text('Day Check OUT'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      'Start Reading',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                Flexible(
                  flex: 4,
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'Enter The Reading',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
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
                "Camera",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )
          ]),
          const SizedBox(
            height: 20,
          ),
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
            ),
          ]),
        ],
      ),
    );
  }
}
