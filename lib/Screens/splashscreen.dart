import 'dart:async';
import 'package:demo/Screens/screens.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigate);
  }

  void navigate() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()))
        .then((value) => Navigator.pop(context));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen[100],
        body: Center(
          child: Container(
            height: 300,
            width: 200,
            child: Column(
              children: [
                Image(image: AssetImage('assets/image.png')),
                Text(
                  "Madeni App",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          color: Colors.lightGreen[100],
          height: 50,
          width: double.infinity,
          child: Center(
            child: RichText(
              text: TextSpan(
                  text: "Designed & Developed by | ",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(
                        text: "musumbidenis",
                        style:
                            TextStyle(color: Colors.green[500], fontSize: 12),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            if (await canLaunch("http://musumbidenis.co.ke")) {
                              await launch("http://musumbidenis.co.ke");
                            }
                          })
                  ]),
            ),
          ),
        ));
  }
}
