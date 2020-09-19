import 'package:demo/Screens/screens.dart';
import 'package:demo/Repository/database.dart';
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
    getTotal();
    greeting();
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
                  size: 70.0,
                  color: Colors.green[300],
                ),
                SizedBox(width: 15.0),
                Text(
                  greeting() + "\nCreditor",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
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
                    topLeft: const Radius.circular(9.0),
                    topRight: const Radius.circular(9.0),
                    bottomLeft: const Radius.circular(9.0),
                    bottomRight: const Radius.circular(9.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                    ),
                  ]),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Debtors()))
                      .then((value) {
                    setState(() {
                      getTotal();
                      greeting();
                    });
                  });
                },
                child: ListTile(
                  title: Text(
                    'Check out debts owed',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  leading: Icon(
                    Icons.check_box,
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
                    bottomLeft: Radius.circular(9.0),
                    bottomRight: Radius.circular(9.0),
                    topRight: Radius.circular(9.0),
                    topLeft: Radius.circular(9.0)),
              ),
              elevation: 1.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("Payment Progress:",
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold)),
                    ),
                    FutureBuilder(
                        future: getTotal(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          /*Checks if the snapshot returns null */
                          var total = snapshot.data[0]['total'] == null
                              ? 0
                              : snapshot.data[0]['total'];
                          var paid = snapshot.data[0]['paid'] == null
                              ? 0
                              : snapshot.data[0]['paid'];

                          /*Gets the remaining balance */
                          var difference = total - paid;

                          /*Gets the total payment percentage */
                          var percentage;
                          if (paid == 0) {
                            percentage = 0.001;
                          } else {
                            percentage = ((paid / total) * 100) / 100;
                          }

                          /*Returns the progress indicator widget */
                          return Center(
                            child: CircularPercentIndicator(
                              radius: 130.0,
                              lineWidth: 15.0,
                              animation: true,
                              percent: percentage,
                              progressColor: percentage >= 0.5
                                  ? Colors.green[300]
                                  : Colors.red,
                              center: Text(
                                "Kshs " + paid.toString() + "\nPaid",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
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
                                        style:
                                            TextStyle(color: Colors.grey[800]),
                                        children: [
                                          TextSpan(
                                              text: "Kshs " +
                                                  difference.toString() +
                                                  " / ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: "Kshs " + total.toString())
                                        ]),
                                  ),
                                ],
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                          );
                        }),
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
