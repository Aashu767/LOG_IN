// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:log_in/Form.dart';
import 'package:log_in/Zone.dart';
import 'package:http/http.dart' as http;
import 'package:log_in/models/complaintlist_model.dart';
import 'package:xml2json/xml2json.dart';

class Complaints extends StatefulWidget {
  String zoneid;
  String menuid;
  Complaints({Key? key, required this.zoneid,required this.menuid}):super(key: key);

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
    var body = {
      "UserID": "1192",
      "TypeID": "0",
      "MenuID": widget.menuid,
      "ZoneID": widget.zoneid,
      // "MenuID": "10005",
      // "ZoneID": "A00011",
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
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => zone(
                          menuid: widget.zoneid,
                        )));
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
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
                          builder: (context) => const Form_page()));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Complaint No. :  ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: '${complist[index].complaintNo}'),
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Customer Name :  ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                        text:
                                            '${complist[index].customerName}'),
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Mobile No. :  ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: '${complist[index].mobileNo}'),
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Address :  ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: '${complist[index].address}'),
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Problem  :  ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: '${complist[index].problem}'),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              //
              ),
    );
  }
}
