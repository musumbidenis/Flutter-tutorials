import 'package:demo/Screens/screens.dart';
// ignore: unused_import
import 'package:demo/Data/data.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
            child: Row(
              children: [
                Icon(
                  Icons.wb_sunny,
                  size: 80.0,
                  color: Colors.green[300],
                ),
                SizedBox(width: 15.0),
                Text(
                  "Good Morning,\nChelsea",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 15.0, right: 30.0, left: 30.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.lightGreen[50],
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(5.0),
                    topRight: const Radius.circular(5.0),
                    bottomLeft: const Radius.circular(5.0),
                    bottomRight: const Radius.circular(5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[800],
                    ),
                  ]),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Debtors()));
                },
                child: ListTile(
                  title: Text(
                    'Check out the debts owed',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  leading: Icon(
                    Icons.monetization_on,
                    size: 30.0,
                  ),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 15.0, right: 30.0, left: 30.0),
            child: Card(
              color: Colors.lightGreen[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                    topLeft: Radius.circular(5.0)),
              ),
              elevation: 1.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Payment Progress:",
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold)),
                    Center(
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
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(color: Colors.grey[800]),
                                  children: [
                                    TextSpan(
                                        text: "Kshs 300 / ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: "Kshs 2000")
                                  ]),
                            ),
                          ],
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
