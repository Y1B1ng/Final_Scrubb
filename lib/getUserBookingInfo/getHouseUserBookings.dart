import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GetHouseUserBookings extends StatelessWidget {

  final String documentId;

  GetHouseUserBookings({required this.documentId});
  final currentUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    //get the collection
    CollectionReference Housekeeping_bookings = FirebaseFirestore.instance.collection('Housekeeping_bookings');

    return FutureBuilder<DocumentSnapshot>(
        future: Housekeeping_bookings.doc(documentId).get(),
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
