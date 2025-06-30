import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipsPage extends StatefulWidget{
  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  var tips=[ "Keep your EMI under 40% of your income.",
    "Choose shorter loan terms to save interest.",
    "Always compare offers from at least 3 banks.",
    "Make pre-payments to close your loan early.",
    "Fixed interest is safer, floating is cheaper.",
    "Maintain a good CIBIL score for better rates.",
    "Avoid loans for luxury expenses.",
    "Never miss EMI payments—it hurts your credit.",
    "Review terms before signing any loan document.",
    "Keep 3-6 months EMI as emergency savings."];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Center(child: Text("Tips         ")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shadowColor: Colors.blue,

              child: ListTile(
                leading: Text("${index+1}"),
                title: Text(tips[index]),
              ),
            ),
          );
        },
        itemCount: tips.length,),
      ),
    );
  }
}