import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class updateUserHouse extends StatefulWidget {
  final String documentId;

  updateUserHouse({required this.documentId});

  @override
  _updateUserHouseState createState() => _updateUserHouseState();
}

class _updateUserHouseState extends State<updateUserHouse> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  TextEditingController notesTextController = TextEditingController();

  @override
  void dispose() {
    nameTextController.dispose();
    phoneTextController.dispose();
    addressTextController.dispose();
    notesTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchBookingsDetails();
  }

  Future<void> fetchBookingsDetails() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Housekeeping_bookings')
          .doc(widget.documentId)
          .get();

      if (documentSnapshot.exists) {
        var data = documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          nameTextController.text = data['Name'];
          phoneTextController.text = data['Phone No'];
          addressTextController.text = data['Address'];
          notesTextController.text = data['Special Notes'];
        });
      }
    } catch (e) {
      print('Error fetching booking details: $e');
    }
  }

  Future<void> updateBookingDetails() async {
    try {
      await FirebaseFirestore.instance
          .collection('Housekeeping_bookings')
          .doc(widget.documentId)
          .update({
        'Name': nameTextController.text,
        'Phone No':phoneTextController.text,
        'Address':addressTextController.text,
        'Special Notes':notesTextController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking details updated successfully')),
      );
    } catch (e) {
      print('Error updating booking details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update booking details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Booking Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameTextController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: phoneTextController,
              decoration: InputDecoration(labelText: 'Phone No'),
            ),
            TextFormField(
              controller: addressTextController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: notesTextController,
              decoration: InputDecoration(labelText: 'Special Notes'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: updateBookingDetails,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
