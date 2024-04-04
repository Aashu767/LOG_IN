// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class payment extends StatefulWidget {
  const payment({super.key});

  @override
  State<payment> createState() => _paymentState();
}
//http://140.238.162.89/ServiceWebAPI/Service.asmx/WS_Insert_PaymentSR
//http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_Customer_PaymentSR

class _paymentState extends State<payment> {
  String _dropDownValue = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {}
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {}
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: const Text('Payment Details'),
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 17),
        ),
        body: SingleChildScrollView(
            child: Card(
                margin: const EdgeInsets.all(16),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color.fromRGBO(230, 230, 250, 1),
                            Colors.white,
                            Color.fromRGBO(230, 230, 250, 1)
                          ]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter Transaction ID',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter ID';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter Customer Name',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter Bank Name',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Bank enter Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: DropdownButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              hint: _dropDownValue == ""
                                  ? const Text('Payment Mode *')
                                  : Text(
                                      _dropDownValue,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                              items: [
                                'Cash Deposite',
                                'Debit/Credit Card',
                                'IMPS',
                                'NEFT',
                                'RTGS',
                              ].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _dropDownValue = val!;
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Enter Amount',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter amount';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Row(children: [
                              IconButton(
                                onPressed: () => {
                                  _selectdate(context),
                                },
                                icon: const Icon(
                                  Icons.calendar_today,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  dateController.text == ""
                                      ? 'Transaction Date *'
                                      : dateController.text,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: Row(children: [
                              IconButton(
                                onPressed: showOptions,
                                icon: const Icon(
                                  (Icons.add_a_photo),
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  'Picture Taken',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.yellow)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Form Submitted')),
                                  );
                                }
                              },
                              child: const Text('Save',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))));
  }

  _selectdate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      print(formattedDate);

      setState(() {
        dateController.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }
}
