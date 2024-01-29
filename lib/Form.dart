// ignore_for_file: camel_case_types, unused_element, non_constant_identifier_names, prefer_final_fields, file_names

import 'package:flutter/material.dart';
// import 'package:log_in/assign.dart';
import 'package:log_in/comp_update.dart';
import 'package:log_in/complaint.dart';

class Form_page extends StatefulWidget {
  const Form_page({super.key});

  @override
  State<Form_page> createState() => _Form_pageState();
}

class _Form_pageState extends State<Form_page> {
  String _dropDownValue = "";
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'complain no. :-',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' 1800245',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Cust. Name  :-',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' xiaomi india',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Mob No. :-',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' 7838468018',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'E-Mail ID :-',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' demo123@gmail.com',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Address :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' B-14 sector-8 Noida',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Colony :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' local colony sector-8 Noida',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Area  :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' NOIDA SECTOR-8',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'CITY :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' NOIDA',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'District  :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' Gautam Budhh Nagar.',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'PIN CODE :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' 201301 ',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Type  :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' NORMAL Complaints',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Prob since:- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' 3 month',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Problem :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' Not Working ',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Assign too :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' _office person name_',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Regis Date :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' 26-12-2023 ',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Clouser Date :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          '_when close_',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'BU_NAME :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          'CANDID OPTRONIX PVT LTD',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Cat-Name :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          '  OPTRONIX  ',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Model Code :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' when enter ',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Product Name :-',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' 10/100 POE Switch ',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'color Name :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' when enter ',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'SIZE CODE :- ',
                          style: tstyle(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          ' when enter ',
                          style: tstyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.yellow)),
                          onPressed: () async {
                            showAlertDialog(context);
                          },
                          child: const Text(
                            "Assign To",
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
                                    builder: (_) => const comp_update()));
                          },
                          child: const Text(
                            "UPDATE",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) async {
    Widget ASSIGNButton = TextButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
      child: const Text("ASSIGN",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Complaints()));
      },
    );
    Widget CANCELButton = TextButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("CANCEL",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
    );

    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      scrollable: true,
      title: const Center(
        child: Text("Assign Complaint",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: Column(
          children: [
            Container(
                decoration: mydecoration(),
                child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Comp No.:',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '1800245',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]))),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: mydecoration(),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return DropdownButton(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  hint: _dropDownValue == ""
                      ? const Text('Select To Assign')
                      : Text(
                          _dropDownValue,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                  items: ['luxmi', 'luxmi', 'luxmi', 'luxmi', 'luxmi'].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    dropDownState(
                      () {
                        _dropDownValue = val!;
                      },
                    );
                  },
                );
              }),
            ),
          ],
        )),
      ),
      actions: [
        ASSIGNButton,
        CANCELButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

TextStyle tstyle() {
  return const TextStyle(
      color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold);
}

BoxDecoration mydecoration() {
  return BoxDecoration(
    border:
        Border.all(style: BorderStyle.solid, color: Colors.black, width: 2.0),
  );
}
