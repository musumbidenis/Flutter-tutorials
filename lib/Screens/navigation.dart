import 'package:demo/Screens/screens.dart';
import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[500],
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelStyle: TextStyle(fontSize: 18.0),
              tabs: [
                Tab(
                  text: "Debtors",
                ),
                Tab(
                  text: "Debts",
                ),
              ],
            ),
            title: Text(
              'Madeni',
              style: TextStyle(fontSize: 21.0),
            ),
          ),
          body: TabBarView(
            children: [
              Debtors(),
              Debts(),
            ],
          ),
        ),
      ),
    );
  }
}
