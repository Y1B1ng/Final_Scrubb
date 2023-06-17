import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scrubb/Payment/cashPayment.dart';
import 'package:scrubb/Payment/ewalletPayment.dart';


class payment extends StatefulWidget {
  @override
  _paymentState createState() => _paymentState();
}

class _paymentState extends State<payment> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      appBar: AppBar(
        title: Text('Payment Method'),
      ),

      body: Column(

        children: [
          SizedBox(height: 100),
          Text('Choose the payment method to know more information:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          SizedBox(height: 30),
          Text('Please make the payment after the service is completed',style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),),
          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> cashPayment(),
              ),);
    },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Icon(Icons.payment), // Replace `Icons.payment` with the desired icon
            SizedBox(width: 15,height: 50,), // Adjust the spacing between the icon and text as needed
            Text('Pay with Cash',style: TextStyle(fontSize: 18),), // Replace 'Pay with Cash' with your desired button text
    ],
      ),
            ),
          ),

          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ewalletPayment(),
                ),);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.payment), // Replace `Icons.payment` with the desired icon
                  SizedBox(width: 15,height: 50,), // Adjust the spacing between the icon and text as needed
                  Text('Pay with E-wallet',style: TextStyle(fontSize: 18),), // Replace 'Pay with Cash' with your desired button text
                ],
              ),

            ),

          ),





      ],
    ),
    );
  }
}
