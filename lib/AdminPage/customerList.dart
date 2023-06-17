import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scrubb/getAdminPagesInfo/getRegUserList.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {

  // Document IDs
  List<String> docIDs = [];

  // Get Document IDs
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
          print(document.reference);
          docIDs.add(document.reference.id);
        },
      ),
    );
  }

  // Delete Document
  void deleteDocument(String documentId) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(documentId)
        .delete()
        .then(
          (value) {
        print("Document deleted successfully!");
        setState(() {
          docIDs.remove(documentId);
        });
      },
    ).catchError((error) {
      print("Failed to delete document: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      appBar: AppBar(
        title: Text('Registered User List'),
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
                        title: GetRegUserInfo(documentId: documentId),
                        tileColor: Colors.purpleAccent[100],
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteDocument(documentId);
                          },
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
