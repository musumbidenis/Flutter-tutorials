import 'package:demo/Data/data.dart';
import 'package:demo/Screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sqflite/sqflite.dart';

class Debts extends StatefulWidget {
  final String name;

  const Debts({Key key, this.name}) : super(key: key);
  @override
  _DebtsState createState() => _DebtsState();
}

class _DebtsState extends State<Debts> {
  int total;
  @override
  void initState() {
    super.initState();
    paid(widget.name);
    getPayments(widget.name);
  }

  paid(String name) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT SUM(amount) as total FROM debts WHERE name = ?', ['$name']);
    return List.generate(maps.length, (index) {
      setState(() {
        total = maps[index]['total'];
      });

      return total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[100],
        title: Text(
          "Debts",
          style: TextStyle(fontSize: 25.0, color: Colors.grey[800]),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              color: Colors.lightGreen[100],
              child: Center(
                child: CircularPercentIndicator(
                  radius: 150.0,
                  lineWidth: 18.0,
                  animation: true,
                  percent: 0.7,
                  progressColor: Colors.green[300],
                  center: FutureBuilder(
                      future: getPayments(widget.name),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return Text(
                          "Kshs " + snapshot.data[0].paid + "\n paid",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        );
                      }),
                  footer: Column(
                    children: [
                      Divider(
                        height: 3,
                      ),
                      SizedBox(height: 10.0),
                      Text("Remaining Balance"),
                      SizedBox(height: 10.0),
                      FutureBuilder(
                          future: getPayments(widget.name),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Colors.grey[800]),
                                    children: [
                                      TextSpan(
                                          text: "c",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              "Kshs " + snapshot.data[0].total),
                                    ]),
                              );
                            }
                          })
                    ],
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
