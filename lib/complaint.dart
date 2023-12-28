import 'package:flutter/material.dart';
import 'package:log_in/Form.dart';

class Complaints extends StatelessWidget {
  const Complaints({super.key});

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
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          return getItem(index, context);
        },
      ),
    );
  }
}

Widget getItem(int index, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const Form_page()));
    },
    child: Container(
      margin: const EdgeInsets.all(16),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'complain no. :',
                  style: tstyle(),
                ),
                Text(
                  ' 180024569',
                  style: tstyle(),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Cust Name:',
                  style: tstyle(),
                ),
                Text(
                  ' xiaomi india',
                  style: tstyle(),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Mob No. :',
                  style: tstyle(),
                ),
                Text(
                  ' 7838468018',
                  style: tstyle(),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Address: ',
                  style: tstyle(),
                ),
                Text(
                  ' B-14 sector-8 Noida',
                  style: tstyle(),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Problem : ',
                  style: tstyle(),
                ),
                Text(
                  ' Not Working',
                  style: tstyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

TextStyle tstyle() {
  return const TextStyle(
    color: Colors.black,
    fontSize: 17,
  );
}
