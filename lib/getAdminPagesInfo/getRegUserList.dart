import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GetRegUserInfo extends StatelessWidget {

  final String documentId;

  GetRegUserInfo({required this.documentId});

  @override
  Widget build(BuildContext context) {

    //get the collection
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');

    return FutureBuilder<DocumentSnapshot>(
        future: Users.doc(documentId).get(),
        builder: ((context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
            return Text(//'Email: ${data['email']},\n '
                'Username: ${data['username']}\n '
            );
          }
          return Text('Loading...');
        }));
  }
}
