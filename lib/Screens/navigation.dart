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
            title: Text(
              "Madeni App",
              style: TextStyle(fontSize: 21.0),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(left: 12.0, bottom: 8.0),
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
                  TabBar(
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
                ],
              ),
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
