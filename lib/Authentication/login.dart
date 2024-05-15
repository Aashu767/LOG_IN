// ignore_for_file: deprecated_member_use, use_super_parameters, use_build_context_synchronously, unused_element, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:log_in/All_MENU.dart/dashbord.dart';
import 'package:log_in/utils/api.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xml2json/xml2json.dart';
import '../utils/secure_storage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _empIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
  final bool _isObscure = true;

  var isDataLoading = false;
  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    setState(() {});
  }

  Future<void> _requestPermission() async {
    setState(() {});
  }

  Future<void> login(String user, String pass) async {
    _loginUserHttp(user, pass);
  }

  _loginUserHttp(String user, String pass) async {
    setState(() {
      isLoading = true;
    });
    var res = await http.post(Uri.parse(AppUrl.Ws_Validate_Login), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "_sUserId": user,
      "_sPwd": pass,
      "_VisitorCode": "",
      "_TenantCode": "",
      "_Location": ""
    });
    var bodyIs = res.body;
    var statusCode = res.statusCode;
    if (statusCode == 200) {
      print("body$bodyIs");
      setState(() {
        isLoading = false;
      });
      Xml2Json xml2Json = Xml2Json();
      xml2Json.parse(bodyIs);
      var jsonString = xml2Json.toParker();
      var data = jsonDecode(jsonString);
      var staffId = data['string'];
      if (!context.mounted) return;
      if (data['string'] != 'false') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  elevation: 10,
                  child: SizedBox(
                      height: 220,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Allow Newton Service to use your location ?",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Newton sales app collects location data to enable attendance & customer visits even when the Sales app is closed or not in use.",
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        _requestPermission();
                                        final status =
                                            await Permission.location.request();
                                        if (status ==
                                            PermissionStatus.granted) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      dashboard()));
                                          await UserSecureStorage()
                                              .setStaffId(staffId);
                                          await UserSecureStorage()
                                              .setuser(user);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => dashboard()));
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text(
                                        "Allow ",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Don't Allow",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              );
            });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User Id or Password is wrong!"),
        ));
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/image/logo.jpg',
              scale: 1.6,
            ),
            const Text(
              'Newton Service',
              style: TextStyle(
                  color: Color.fromARGB(255, 60, 79, 112),
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.7,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  color: Colors.white,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: _empIdController,
                                decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(15.0),
                                    labelText: 'Login Id',
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'The field is mandatory';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(15.0),
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _isObscure,
                                enableSuggestions: false,
                                autocorrect: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'The field is mandatory';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              isLoading
                                  ? const SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator())
                                  : GestureDetector(
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          login(_empIdController.text,
                                              _passwordController.text);
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromARGB(
                                              255, 16, 36, 53),
                                        ),
                                        height: 38,
                                        child: Center(
                                          child: isLoading
                                              ? const SizedBox(
                                                  width: 23,
                                                  height: 23,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ))
                                              : const Text(
                                                  'Log in',
                                                  textScaleFactor: 1.1,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                        ),
                                      ),
                                    ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
