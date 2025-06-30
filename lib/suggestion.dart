import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:intl/intl.dart';

class Suggestion extends StatefulWidget{
  final double monthlyIncome;

  Suggestion({required this.monthlyIncome});
  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  String msg="";

 @override
  void initState() {
   super.initState();
  msg= getLoanSuggestion(widget.monthlyIncome);
  }
  String getLoanSuggestion(double monthlyIncome) {
    double safeEmi = monthlyIncome * 0.4; // Suggest EMI <= 40% of income
    int term = 60; // 5 years
    double interestRate = 10.0;

    double R = interestRate / 12 / 100;
    double suggestedLoan = safeEmi * (pow(1 + R, term) - 1) / (R * pow(1 + R, term));
    String formattedLoan = NumberFormat('#,##,###').format(suggestedLoan);

    if(suggestedLoan==0.0) return "    No Suggestion available";
    return "Based on your income, you can safely borrow up to ₹$formattedLoan over $term months at $interestRate% interest.";

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Center(child: Text("Suggestion      ")),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
          
                Container(
                  child: Image.asset("assets/images/suggestion.jpg"),
                ),
          
                SizedBox(height: 25,),
          
                Container(
                  width: 250,
          
                  child: Text("$msg",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                ),
              ],
            ),
          ),
        ),

    );
  }
}
