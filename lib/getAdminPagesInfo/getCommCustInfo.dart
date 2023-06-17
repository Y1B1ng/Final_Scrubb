import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GetCommCusInfo extends StatelessWidget {

  final String documentId;

  GetCommCusInfo({required this.documentId});

  @override
  Widget build(BuildContext context) {

    //get the collection
    CollectionReference Commercial_bookings = FirebaseFirestore.instance.collection('Commercial_bookings');

    return FutureBuilder<DocumentSnapshot>(
      future: Commercial_bookings.doc(documentId).get(),
        builder: ((context, snapshot){
      if (snapshot.connectionState == ConnectionState.done){
        Map<String, dynamic> data =
        snapshot.data!.data() as Map<String, dynamic>;
        return Text(' Name: ${data['Name']},\n '
            'Phone No: ${data['Phone No']},\n '
            'Address: ${data['Address']}, \n '
            'Special Notes: ${data['Special Notes']}, \n'
            'Date: ${data['Date']}'
        );
      }
      return Text('Loading...');
    }));
  }
}
