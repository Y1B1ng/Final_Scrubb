import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:scrubb/components/ProceedButton.dart';

import '../main.dart';

class ewalletPayment extends StatefulWidget {
  const ewalletPayment({Key? key}) : super(key: key);

  @override
  State<ewalletPayment> createState() => _ewalletPaymentState();
}

class _ewalletPaymentState extends State<ewalletPayment> {

  void payWithEwallet()async {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> bottomBarNavi(),
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      appBar: AppBar(
        title: Text('E Wallet Payment'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 110),
            Text('Only GrabPay and TnG E-wallet are available',style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('images/GrabPay.png'),height: 100,width: 100,),
                SizedBox(width: 10,),
                Image(image: AssetImage('images/TouchNgo.png'),height: 150,width: 150,),
              ],
            ), //grabpay and TnG pic
            SizedBox(height: 30),
            Text('Transfer the amount to this phone number:',style: TextStyle(fontSize: 18),),
            SizedBox(height: 15),
            Text('+60 113 6554 6534',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            SizedBox(height: 15),
            Text('Please pay upon the service is completed',style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic),),

            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ProceedButton(
                  onTap: payWithEwallet,
                  text: 'Continue'),
            ),
          ],

        ),
      ),

    );
  }
}
