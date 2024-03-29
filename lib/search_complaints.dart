// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:log_in/dashbord.dart';
import 'package:log_in/models/zone_model.dart';

class Search_complaints extends StatefulWidget {
  const Search_complaints({super.key});

  @override
  State<Search_complaints> createState() => _Search_complaintsState();
}

class _Search_complaintsState extends State<Search_complaints> {
  bool isLoading = true;
  List<ComplaintsType> zonelist = [];

  @override
  Widget build(BuildContext context) {
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
          title: const Text('   Complaints Search '),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          actions: const [
            Row(
              children: [],
            ),
          ],
        ),
        body: Container());
  }
}
