import 'package:flutter/material.dart';
import 'package:scrubb/components/ProceedButton.dart';
import 'package:scrubb/main.dart';

class cashPayment extends StatefulWidget {
  const cashPayment({Key? key}) : super(key: key);

  @override
  State<cashPayment> createState() => _cashPaymentState();
}

class _cashPaymentState extends State<cashPayment> {

  void payWithCash()async {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> bottomBarNavi(),
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      appBar: AppBar(
        title: Text('Cash Payment'),
      ),
       body: Center(
         child: Column(
           children: [
             SizedBox(height: 150),
             Text('Pay with cash upon the service is completed',style: TextStyle(fontSize: 18),),

             SizedBox(height: 30),
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: ProceedButton(
                   onTap: payWithCash,
                   text: 'Continue'),
             ),
           ],

         ),
       ),



    );
  }
}
