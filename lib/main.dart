import 'dart:core';
import 'package:flutter/services.dart';
import 'package:emi/splashscreen.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'chatbot.dart';
import 'suggestion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class CommaFormatter extends TextInputFormatter{
  final NumberFormat formatter=NumberFormat('#,##,###');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldvalue,
    TextEditingValue newvalue,
  ){
    String text=newvalue.text.replaceAll(',','');
    if(text.isEmpty) return newvalue;

    final number=int.tryParse(text);
    if(number==null){
      return oldvalue;
    }
    final newText =formatter.format(number);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var loanController= TextEditingController();
  var interestController= TextEditingController();
  var termController= TextEditingController();
  var monthController= TextEditingController();

  double emiresult=0.0;
  double totalamount=0.0;
  double tip=0.0;
  double emip=0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Center(child: Text("EMI Calculator")),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const[
        BottomNavigationBarItem(
            label: "Tips",
            icon:Icon(Icons.tips_and_updates_sharp,
            ),
        ),
        BottomNavigationBarItem(
            icon:Icon(Icons.home),
            label: "Home",
        ),
        BottomNavigationBarItem(
            icon:Icon(Icons.lightbulb),
            label: "Suggestions",
        ),
      ],
      currentIndex: 1,
      onTap: (index){
        if(index==0){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TipsPage()));
        }
        if(index==2){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Suggestion(monthlyIncome: double.tryParse(monthController.text.replaceAll(',',''))??0.0,)));
        }
      },
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 30,),
                //loan amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 50,
                      child: Center(child: Text("Loan Amount: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: loanController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [CommaFormatter()],
                        decoration: InputDecoration(
                          hintText:"enter amount...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color:Colors.black,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),

                      ),
                    )
                  ],
                ),

                SizedBox(height: 30,),

                //interest rate
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 50,
                      child: Center(child: Text(" Interest Rate:   ",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),)),
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: interestController,
                        inputFormatters: [CommaFormatter()],
                        decoration: InputDecoration(
                          hintText: "enter interest rate...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30,),

                //loan term

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 150,
                      child: Center(child: Text("Loan Term:      ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)),
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: termController,
                        inputFormatters: [CommaFormatter()],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                            hintText: "enter loan term (in months)",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(11),
                            )
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 30,),

                //monthly income

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 50,
                      child: Center(child: Text("Monthly   \nIncome:           ", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),)),
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: monthController,
                        inputFormatters: [CommaFormatter()],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                            hintText: "enter monthly income...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(11),
                            )
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        var lamount= double.tryParse(loanController.text.replaceAll(',', ''))??0;
                        var rate=double.tryParse(interestController.text.replaceAll(',', ''))??0;
                        var term=double.tryParse(termController.text.replaceAll(',', ''))??0;
                        var month=double.tryParse(monthController.text.replaceAll(',', ''))??0;

                        double R= rate/12/100;
                        double emi;
                        if(R==0){
                          emi=lamount/term;
                        }
                        else {
                          emi = lamount * R * pow(1 + R, term) / (pow(1 + R, term) - 1);
                        }
                        setState(() {
                          emiresult=emi;
                          totalamount=emi*term;
                          tip=totalamount-lamount;
                          emip= (emi/month)*100;
                        });
                      },
                      child: Container(
                        width: 190,
                        height: 50,
                        child: Center(child: Text("Calculate",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),

                    SizedBox(width: 20,),

                    InkWell(
                      onTap:(){
                        loanController.clear();
                        interestController.clear();
                        termController.clear();
                        monthController.clear();
                        setState(() {
                          emiresult=0.00;
                          totalamount=0.0;
                          tip=0.0;
                          emip=0.0;
                        });
                      },
                      child: Container(
                        width: 190,
                        height: 50,
                        child: Center(child: Text("Reset",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.lightBlue,
                        ),

                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),

                Wrap(
                  runSpacing: 25,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: Center(child: Text("EMI is:  ₹${NumberFormat('#,##,###.00').format(emiresult)}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),)),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Center(child: Text("Total Amount Payable:  is ₹${NumberFormat('#,##,###.00').format(totalamount)}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),)),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      width: double.infinity,
                      height: 50,
                      child: Center(child: Text("Total Interest Payable is: ₹${NumberFormat('#,##,###.00').format(tip)}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      width: double.infinity,
                      height: 50,
                      child: Center(child: Text("EMI as % of Monthly Income: ₹${NumberFormat('#,##,###.00').format(emip)}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}