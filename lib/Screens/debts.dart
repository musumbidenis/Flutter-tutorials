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
  @override
  void initState() {
    super.initState();
    paid(widget.name);
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
              height: MediaQuery.of(context).size.height * 0.4,
              color: Colors.lightGreen[100],
              child: Center(
                child: CircularPercentIndicator(
                  radius: 150.0,
                  lineWidth: 18.0,
                  animation: true,
                  percent: 0.7,
                  progressColor: Colors.green[300],
                  center: Text(
                    "Kshs. 200" + "\nPaid",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  footer: Column(
                    children: [
                      Divider(
                        height: 3,
                      ),
                      SizedBox(height: 10.0),
                      Text("Remaining Balance"),
                      SizedBox(height: 10.0),
                      Container(
                        height: 20,
                        child: FutureBuilder(
                            future: getDebts(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Text(snapshot.data.name[0]);
                              }
                            }),
                      ),
                      // RichText(
                      //   text: TextSpan(
                      //       style: TextStyle(color: Colors.grey[800]),
                      //       children: [
                      //         TextSpan(
                      //             text: "Kshs 300 / ",
                      //             style:
                      //                 TextStyle(fontWeight: FontWeight.bold)),
                      //         TextSpan(text: "Kshs 2000")
                      //       ]),
                      // ),
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
