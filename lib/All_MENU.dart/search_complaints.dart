// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:log_in/All_MENU.dart/dashbord.dart';
import 'package:log_in/edit_pages.dart/Form.dart';
import 'package:log_in/models/search_model.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

class Search_complaints extends StatefulWidget {
  const Search_complaints({super.key});

  @override
  State<Search_complaints> createState() => _Search_complaintsState();
}

class _Search_complaintsState extends State<Search_complaints> {
  final TextEditingController _controller = TextEditingController();
  late List<String> searchData = [];
  List<ComplaintsList1> searchlist = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  fetchsearchApi() async {
    var body = {
      "SearchString": _controller.text,
    };

    var res = await http.post(
        Uri.parse(
            "http://140.238.162.89/ServiceWebAPI/Service.asmx/Search_ComplaintsList"),
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
      var searchliststring = data['string'];
      searchliststring =
          searchliststring.toString().replaceAll("\\r\\\\n", "\n");
      var searchobject = json.decode(searchliststring.toString());
      var searchlistobject = searchobject['Complaints_List'];
      Iterable l = searchlistobject;
      setState(() {
        searchlist = l.map((data) => ComplaintsList1.fromJson(data)).toList();
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
          automaticallyImplyLeading: false,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => dashboard()));
            },
          ),
          backgroundColor: Colors.white,
          title: const Text(
            ' Complaints Search',
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                        onPressed: () {
                          fetchsearchApi();
                        },
                        icon: const Icon(Icons.search))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: searchlist.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Form_page(
                                        compno: searchlist[index].complaintNo!,
                                      ))));
                        },
                        child: Container(
                          height: 150,
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
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: 'Complaint No. :  ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                            text:
                                                '${searchlist[index].complaintNo}'),
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Customer Name :  ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                            text:
                                                '${searchlist[index].customerName}'),
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Mobile No. :  ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                            text:
                                                '${searchlist[index].mobileNo}'),
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'kNO :  ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: '${searchlist[index].kNo}'),
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Problem  :  ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                            text:
                                                '${searchlist[index].problem}'),
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Address :  ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                            text:
                                                '${searchlist[index].address}'),
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Problem  :  ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                            text:
                                                '${searchlist[index].problem}'),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}