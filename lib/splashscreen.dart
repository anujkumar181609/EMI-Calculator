import 'dart:async';

import 'package:emi/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3),(){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
      child: Image.asset("assets/images/emmi.png"),
      decoration: BoxDecoration(
        gradient: RadialGradient(colors: [Colors.yellow,Colors.blue])
      ),

      ),
    );
  }
}