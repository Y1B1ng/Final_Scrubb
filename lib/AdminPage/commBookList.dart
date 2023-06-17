import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scrubb/getAdminPagesInfo/getCommCustInfo.dart';
import 'package:scrubb/getAdminPagesInfo/updateCommBook.dart';

class commBookList extends StatefulWidget {
  const commBookList({Key? key}) : super(key: key);

  @override
  State<commBookList> createState() => _commBookListState();
}

class _commBookListState extends State<commBookList> {
  // Document IDs
  List<String> docIDs = [];

  // Get Document IDs
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Commercial_bookings')
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
        .collection('Commercial_bookings')
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

  // Edit Document
  void editDocument(String documentId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => updateCommBook(documentId: documentId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      appBar: AppBar(
        title: Text('Commercial Bookings List'),
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
                        title: GetCommCusInfo(documentId: documentId),
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
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteDocument(documentId);
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
