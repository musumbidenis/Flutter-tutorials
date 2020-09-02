import 'package:flutter/material.dart';

class Debts extends StatefulWidget {
  @override
  _DebtsState createState() => _DebtsState();
}

class _DebtsState extends State<Debts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      body: Container(
        height: 100.0,
        color: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green[500],
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
