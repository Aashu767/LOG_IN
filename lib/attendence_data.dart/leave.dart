// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:log_in/All_MENU.dart/attandance.dart';

class leave extends StatefulWidget {
  const leave({super.key});

  @override
  State<leave> createState() => _leaveState();
}

class _leaveState extends State<leave> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController readingcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          'Leave Request',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Reason Of Leave",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: readingcontroller,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    hintText: '  Enter Raason For Leave',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Reason';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.blue,
                  height: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "No Of Days",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: readingcontroller,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    hintText: '  Enter No.Of Days ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter No.Of Days';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.blue,
                  height: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "From Date",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    hintText: ' Enter Date dd-mm-yyyy',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.blue,
                  height: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "To Date",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    hintText: ' Enter Date dd-mm-yyyy',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.blue,
                  height: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Remarks",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    hintText: ' Enter Remarks',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.blue,
                  height: 5,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.yellow)),
                        onPressed: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Enter All Details')),
                            );
                          }
                        },
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
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.yellow)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const attandance()));
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
