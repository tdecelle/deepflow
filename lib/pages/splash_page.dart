import 'dart:async';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({this.callback});

  final callback;

  _SplashPageState createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    if (widget.callback != null) {
      Timer(Duration(seconds: 1), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.callback)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/flow.png'),
      ),
    );
  }

}