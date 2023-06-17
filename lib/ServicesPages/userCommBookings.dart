import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrubb/getUserBookingInfo/getCommUserBookings.dart';
import 'package:scrubb/getUserBookingInfo/updateUserComm.dart';


class userCommBookings extends StatefulWidget {
  const userCommBookings({Key? key}) : super(key: key);

  @override
  State<userCommBookings> createState() => _userCommBookingsState();
}

class _userCommBookingsState extends State<userCommBookings> {

  //document IDs
  List<String>docIDs =[];
  final currentUser = FirebaseAuth.instance;

  //get docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('Commercial_bookings')
        .where("Email",isEqualTo: currentUser.currentUser!.email).get().then(
          (snapshot) => snapshot.docs.forEach(
              (document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
    );
  }

  // Edit Document
  void editDocument(String documentId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => updateUserComm(documentId: documentId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      appBar: AppBar(
        title: Text('Commercial Service Bookings'),
      ),

      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getDocId(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    final documentId = docIDs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: GetUserBookings(documentId: documentId),
                        tileColor: Colors.purpleAccent[100],
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                editDocument(documentId);
                              },
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
