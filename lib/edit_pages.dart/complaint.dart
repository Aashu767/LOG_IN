// ignore_for_file: avoid_print, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:log_in/edit_pages.dart/Form.dart';
import 'package:http/http.dart' as http;
import 'package:log_in/models/complaintlist_model.dart';
import 'package:log_in/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

class Complaints extends StatefulWidget {
  String zoneid;
  String menuid;
  Complaints({super.key, required this.zoneid, required this.menuid});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  bool isLoading = true;

  List<ComplaintsList> complist = [];

  @override
  void initState() {
    super.initState();
    fetchcompApi();
  }

  fetchcompApi() async {
    var staffId = await UserSecureStorage().getStaffId();
    var body = {
      "UserID": staffId,
      "TypeID": "0",
      "MenuID": widget.menuid,
      "ZoneID": widget.zoneid,
      "dt1": "0",
      "dt2": "0",
    };

    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Ws_Get_All_ComplaintsList_SR"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: body);
    var bodyIs = res.body;
    var statuCode = res.statusCode;
    if (statuCode == 200) {
      debugPrint("reis${res.body}");
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(bodyIs);
      var jsonString = xml2json.toParker();
      var data = jsonDecode(jsonString);
      var compliststring = data['string'];
      compliststring = compliststring.toString().replaceAll("\\r\\\\n", "\n");
      var compobject = json.decode(compliststring.toString());
      var complistobject = compobject['Complaints_List'];
      Iterable l = complistobject;
      setState(() {
        complist = l.map((data) => ComplaintsList.fromJson(data)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFF9800),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: const Text('COMPLAINTS'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: complist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Form_page(
                                compno: complist[index].complaintNo!,
                              )));
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0,
                                      right: 10.0,
                                      top: 10.0,
                                      bottom: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Complaint No ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        'Customer Name ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        'Mobile No ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        'Address ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        'Problem ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                const Column(
                                  children: [
                                    Text(
                                      ': ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      ': ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      ': ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      ': ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      ': ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${complist[index].complaintNo}',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        '${complist[index].customerName}',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        '${complist[index].mobileNo}',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        '${complist[index].address}',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        '${complist[index].problem}',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
