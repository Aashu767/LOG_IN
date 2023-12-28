// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:log_in/log_in.dart';

void main() {
  runApp(const login());
}

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: _removeTransitions(),
      ),
      debugShowCheckedModeBanner: false,
      home: const log_in(),
    );
  }
}

_removeTransitions() {}
