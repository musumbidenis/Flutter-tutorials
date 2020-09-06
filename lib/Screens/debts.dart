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
    getPayments(widget.name);
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
            padding: const EdgeInsets.all(0.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              color: Colors.lightGreen[100],
              child: FutureBuilder(
                  future: getPayments(widget.name),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    var a = snapshot.data[0].total;
                    var b = 0;
                    var c = a - b;
                    var d = ((b / a) * 100) / 100;
                    double percentage;
                    if (b == 0) {
                      percentage = 0.0;
                    } else {
                      percentage = d.toDouble();
                    }
                    return Center(
                      child: CircularPercentIndicator(
                        radius: 150.0,
                        lineWidth: 18.0,
                        animation: true,
                        percent: percentage,
                        backgroundColor: Colors.grey[350],
                        progressColor:
                            percentage >= 0.5 ? Colors.green[300] : Colors.red,
                        center: Text(
                          "Kshs " +
                              snapshot.data[0].paid.toString() +
                              "\n paid",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        footer: Column(
                          children: [
                            Divider(
                              height: 3,
                              indent: 20.0,
                              endIndent: 20.0,
                            ),
                            SizedBox(height: 10.0),
                            Text("Remaining Balance"),
                            SizedBox(height: 10.0),
                            FutureBuilder(
                                future: getPayments(widget.name),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.grey[800]),
                                          children: [
                                            TextSpan(
                                                text: "Kshs" +
                                                    c.toString() +
                                                    " / ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: "Kshs " +
                                                    snapshot.data[0].total
                                                        .toString()),
                                          ]),
                                    );
                                  }
                                })
                          ],
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    );
                  }),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: FutureBuilder(
                future: getDebts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100.0,
                              color: Colors.yellow,
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
