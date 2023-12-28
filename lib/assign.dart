// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class assign extends StatefulWidget {
  const assign({super.key});

  @override
  State<assign> createState() => _assignState();
}

class _assignState extends State<assign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        title: const Text('COMPLAINTS'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: Colors.blueAccent,
    );
  }
}
