import 'dart:async';

import 'package:demo/Data/data.dart';
import 'package:demo/Models/models.dart';
import 'package:flutter/material.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

class Debtors extends StatefulWidget {
  @override
  _DebtorsState createState() => _DebtorsState();
}

class _DebtorsState extends State<Debtors> {
  Stream stream;
  StreamController streamController;

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<FormState> _formKey = GlobalKey();

  /*Text Controllers */
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text(
          "Madeni App",
          style: TextStyle(fontSize: 21.0),
        ),
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
                        color: Colors.lightGreen[100],
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 8.0,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
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
                        onTap: null,
                        child: ListTile(
                          title: Text(
                            snapshot.data[index].name,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          leading: Icon(
                            Icons.monetization_on,
                            size: 30.0,
                          ),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                      ),
                    );
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Colors.green[500],
        tooltip: 'Add new debtor',
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  void onPressed() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return PlatformAlertDialog(
          title: Text('Add New Debtor'),
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
                          borderSide: BorderSide(color: Colors.pinkAccent)),
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
                          borderSide: BorderSide(color: Colors.pinkAccent)),
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
              onPressed: handleSubmit,
            ),
          ],
        );
      },
    );
  }

  void handleSubmit() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      var newDebtor = Debtor(
        name: name.text,
        phone: phone.text,
      );
      insertDebtor(newDebtor);
      debtors();

      Navigator.pop(context);
    }
  }
}