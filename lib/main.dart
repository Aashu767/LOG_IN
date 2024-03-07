// ignore_for_file: camel_case_types, unused_import

import 'package:flutter/material.dart';
import 'package:log_in/Authentication/splash.dart';

void main() {
  runApp(const login());
  // runApp(const login());
}

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        pageTransitionsTheme: _removeTransitions(),
      ),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}

_removeTransitions() {}
