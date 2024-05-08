// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        backgroundColor: const Color(0xffF9FAFF),
        appBar: AppBar(
          backgroundColor: const Color(0xffFF9800),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          title: const Text(
            ' Complaints Search',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.06,
                child: TextField(
                  controller: _controller,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Complant No. / Mob No...',
                      suffixIcon: IconButton(
                          onPressed: () {
                            fetchsearchApi();
                          },
                          icon: const Icon(Icons.search))),
                ),
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
                        child: Card(
                          elevation: 5,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
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
                                          left: 10.0,
                                          right: 0.0,
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
                                            'K No ',
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
                                            '${searchlist[index].complaintNo}',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '${searchlist[index].customerName}',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '${searchlist[index].mobileNo}',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '${searchlist[index].kNo}',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '${searchlist[index].address}',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '${searchlist[index].problem}',
                                            style:
                                                const TextStyle(fontSize: 18),
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
            ),
          ],
        ));
  }
}
