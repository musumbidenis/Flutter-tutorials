import 'package:demo/Data/data.dart';
import 'package:demo/Screens/screens.dart';
import 'package:demo/Models/models.dart';
import 'package:flutter/material.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

class Debtors extends StatefulWidget {
  @override
  _DebtorsState createState() => _DebtorsState();
}

class _DebtorsState extends State<Debtors> {
  @override
  void initState() {
    super.initState();
    getDebtors();
  }

  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> _formKey2 = GlobalKey();

  /*Text Controllers */
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController debt = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        title: Text(
          "Madeni App",
          style: TextStyle(fontSize: 25.0, color: Colors.grey[800]),
        ),
        elevation: 0.0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 12.0, bottom: 18.0),
                    decoration: BoxDecoration(
                        color: Colors.lightGreen[50],
                        borderRadius: BorderRadius.circular(24.0)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          contentPadding: const EdgeInsets.only(left: 24.0),
                          border: InputBorder.none),
                    ),
                  )),
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {})
                ],
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
          future: getDebtors(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Debts(
                                      name: "${snapshot.data[index].name}",
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 18.0),
                        child: Container(
                            height: 95.0,
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
                                    color: Colors.grey[800],
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.green[300],
                                    radius: 30.0,
                                    child: Text(
                                      snapshot.data[index].name[0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 28.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data[index].name
                                              .toUpperCase(),
                                          style: TextStyle(fontSize: 17.0),
                                        ),
                                        // RichText(
                                        //   text: TextSpan(
                                        //       style: TextStyle(
                                        //           color: Colors.grey[800]),
                                        //       children: [
                                        //         TextSpan(
                                        //             text: "Kshs 300 / ",
                                        //             style: TextStyle(
                                        //                 fontWeight:
                                        //                     FontWeight.bold)),
                                        //         TextSpan(text: "Kshs 2000")
                                        //       ]),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_box,
                                      size: 31.0,
                                      color: Colors.green[300],
                                    ),
                                    onPressed: () {
                                      showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PlatformAlertDialog(
                                            title: Center(
                                                child: Text('Add New Debt')),
                                            content: SingleChildScrollView(
                                              child: Form(
                                                key: _formKey2,
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      controller: debt,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: "DEBT",
                                                        labelStyle: TextStyle(
                                                          fontFamily:
                                                              'Source Sans Pro',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .pinkAccent)),
                                                      ),
                                                      // ignore: missing_return
                                                      validator:
                                                          (String value) {
                                                        if (value.isEmpty) {
                                                          return "DEBT field cannot be blank";
                                                        }
                                                      },
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    TextFormField(
                                                      controller: amount,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: "AMOUNT",
                                                        labelStyle: TextStyle(
                                                          fontFamily:
                                                              'Source Sans Pro',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .pinkAccent)),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      // ignore: missing_return
                                                      validator:
                                                          (String value) {
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
                                                  child: Text('SUBMIT'),
                                                  actionType:
                                                      ActionType.Preferred,
                                                  onPressed: () {
                                                    var form2 =
                                                        _formKey2.currentState;
                                                    if (form2.validate()) {
                                                      var newDebt = Debt(
                                                        name: snapshot
                                                            .data[index].name,
                                                        debt: debt.text,
                                                        amount: amount.text,
                                                      );

                                                      insertDebt(newDebt);
                                                      updatePayment(snapshot
                                                          .data[index].name);

                                                      Navigator.pop(context);

                                                      debt.clear();
                                                      amount.clear();
                                                    }
                                                  }),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )),
                      ),
                    );
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[300],
          tooltip: 'Add new debtor',
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return PlatformAlertDialog(
                  title: Center(child: Text('Add New Debtor')),
                  content: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                              labelText: "NAME",
                              labelStyle: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.pinkAccent)),
                            ),
                            // ignore: missing_return
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "NAME field cannot be blank";
                              }
                            },
                          ),
                          SizedBox(height: 8.0),
                          TextFormField(
                            controller: phone,
                            decoration: InputDecoration(
                              labelText: "PHONE",
                              labelStyle: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.pinkAccent)),
                            ),
                            keyboardType: TextInputType.phone,
                            // ignore: missing_return
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "PHONE field cannot be blank";
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    PlatformDialogAction(
                      child: Text('SUBMIT'),
                      actionType: ActionType.Preferred,
                      onPressed: () {
                        var form = _formKey.currentState;
                        if (form.validate()) {
                          /*Add Debtors details to db */
                          var newDebtor = Debtor(
                            name: name.text,
                            phone: phone.text,
                          );
                          insertDebtor(newDebtor);

                          /*Add new payment record fro debtor to db */
                          var newPayment = Payment(
                            name: name.text,
                            total: 0,
                            paid: 0,
                          );

                          insertPayment(newPayment);

                          Navigator.pop(context);

                          name.clear();
                          phone.clear();
                        }
                      },
                    ),
                  ],
                );
              },
            );
          }),
    );
  }
}
