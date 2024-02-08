import 'dart:async';
import 'package:flutter/material.dart';
import 'package:log_in/Authentication/login.dart';
import 'package:log_in/dashbord.dart';

import '../utils/secure_storage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getStaffCode();
    Timer(const Duration(seconds: 3), () => navigation());
    // getCoordinates();
    // startTimer();
  }

  var staffuser;

  getStaffCode() async {
    staffuser = await UserSecureStorage().getuser();
  }

  void navigation() async {
    /* SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("EmpId") != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const Dashboard()));
    } else {*/
    getStaffCode();
    var staffId = await UserSecureStorage().getStaffId();
    if (staffId != null && staffId.toString().isNotEmpty) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => dashboard()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              //const Login()
              const Login()));
    }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/image/logo.jpg',
        ),
      ),
    );
  }
}
