import 'package:demo/Repository/database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

class Debts extends StatefulWidget {
  final String name;

  const Debts({Key key, this.name}) : super(key: key);
  @override
  _DebtsState createState() => _DebtsState();
}

class _DebtsState extends State<Debts> {
  int balance;
  /*Form key && Textediting controller */
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    super.initState();
    getDebts(widget.name);
    getPayments(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[100],
        title: Text(
          "Debts",
          style: TextStyle(fontSize: 20.0, color: Colors.grey[800]),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  size: 20.0,
                  color: Colors.grey[800],
                ),
                onPressed: handleDelete,
              ))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
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
                      color: Colors.grey[300],
                    ),
                  ]),
              child: Column(
                children: [
                  Center(
                    child: Text("Payment Progress:",
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold)),
                  ),
                  FutureBuilder(
                      future: getPayments(widget.name),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        var total = snapshot.data[0].total;
                        var paid = snapshot.data[0].paid;

                        /*Gets the remaining balance */
                        balance = total - paid;

                        /*Gets the payment percentage for debtor */
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
                              "Kshs " +
                                  snapshot.data[0].paid.toString() +
                                  "\n paid",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
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
                                                    text: "Kshs " +
                                                        balance.toString() +
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
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    })
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
          FutureBuilder(
              future: getDebts(widget.name),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                /*Checks the snapshot length */
                if (snapshot.data.length == 0 || snapshot.data.length == null) {
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .2),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.grey[800]),
                          children: [
                            TextSpan(
                                text: widget.name.toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: " has no debt records.",
                                style: TextStyle(fontSize: 17.0)),
                          ]),
                    ),
                  ));

                  /*Return a listview of the debts where snapshot length > 0 */
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15.0),
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
                                    color: Colors.grey[300],
                                  ),
                                ]),
                            child: ListTile(
                              leading: Icon(
                                Icons.error_outline,
                                size: 30.0,
                                color: Colors.red,
                              ),
                              title:
                                  Text(snapshot.data[index].debt.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      )),
                              subtitle: Text(
                                snapshot.data[index].timestamp,
                                style: TextStyle(fontSize: 10.0),
                              ),
                              trailing: Text(
                                "Kshs " + snapshot.data[index].amount,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        );
                      });
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Reduce debt"),
        backgroundColor: Colors.green[300],
        tooltip: 'Reduce Total Debt',
        icon: Icon(
          Icons.check_circle,
        ),
        onPressed: onPressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

/*Shows the reduce debt form modal */
  onPressed() async {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return PlatformAlertDialog(
              title: Center(child: Text('Reduce Total Debt')),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: amount,
                        decoration: InputDecoration(
                          labelText: "AMOUNT",
                          labelStyle: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400],
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green[300])),
                        ),
                        keyboardType: TextInputType.number,
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "AMOUNT field cannot be blank";
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                PlatformDialogAction(
                  child: Text('UPDATE'),
                  actionType: ActionType.Preferred,
                  onPressed: handleUpdate,
                ),
                PlatformDialogAction(
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

/*Handles payment records update */
  handleUpdate() {
    var form = _formKey.currentState;
    if (form.validate()) {
      /*Updates payment records && returns to debts screen */
      reduceDebt(widget.name, amount.text);

      /*Refreshes the payment progress UI */
      setState(() {
        getPayments(widget.name);
      });

      Navigator.of(context).pop();

      /*Clears textform field */
      amount.clear();
    }
  }

/*Handles deletion confirmation */
  handleDelete() async {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return PlatformAlertDialog(
              title: Center(child: Text('Delete Action')),
              content: SingleChildScrollView(
                  child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey[800]),
                        children: [
                          TextSpan(
                              text: "Are you sure, you want to delete all of "),
                          TextSpan(
                              text: widget.name.toUpperCase() + "'s ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: "debt records?"),
                        ]),
                  ),
                ],
              )),
              actions: <Widget>[
                PlatformDialogAction(
                    child: Text('YES'),
                    actionType: ActionType.Preferred,
                    onPressed: () {
                      delete(widget.name);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }),
                PlatformDialogAction(
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
}
