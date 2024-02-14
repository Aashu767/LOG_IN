// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:log_in/dashbord.dart';

class log_in extends StatefulWidget {
  const log_in({super.key});

  @override
  State<log_in> createState() => _log_inState();
}

class _log_inState extends State<log_in> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Newton'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 70, bottom: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  child: Image.asset(
                    'assets/image/newton.png',
                    height: 100,
                    width: 200,
                    fit: BoxFit.fill,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                const Text(
                  'NIPPON DATA SYSTEM LTD',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                          hintText: 'Enter valid mail id as abc@gmail.com'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter your secure password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => dashboard()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill input')),
                        );
                      }
                    },
                    child: const Text(
                      'SingIN',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
