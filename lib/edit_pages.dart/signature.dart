// ignore_for_file: unnecessary_import, use_build_context_synchronously, deprecated_member_use

import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  SignatureController signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Signature'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Signature(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                controller: signatureController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                padButtonOption(Colors.redAccent, 'Clear', () {
                  signatureController.clear();
                }),
                padButtonOption(Colors.greenAccent, 'Done', () async {
                  if (signatureController.isNotEmpty) {
                    final signature = await exportSignature();
                    if (signature.isNotEmpty) {
                      Navigator.pop(context, signature);
                    }
                  }
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: signatureController.points,
    );

    final signature = await exportController.toPngBytes();
    exportController.dispose();
    return signature!;
  }

  ElevatedButton padButtonOption(
      Color btnClr, String btnTxt, Function() btnOnTapAction) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(btnClr),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            textStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 14, color: Colors.white))),
        onPressed: btnOnTapAction,
        child: Text(btnTxt));
  }
}
