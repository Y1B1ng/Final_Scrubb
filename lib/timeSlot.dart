import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ServicesPages/selectionComm.dart';


class TimeSlot {
  final String time;
  final int seatsAvailable;

  TimeSlot({required this.time, required this.seatsAvailable});
}

class timeSlot extends StatefulWidget {
  const timeSlot({Key? key}) : super(key: key);

  @override
  State<timeSlot> createState() => _timeSlotState();
}

class _timeSlotState extends State<timeSlot> {
  final List<TimeSlot> _timeSlots = [
    TimeSlot(time: '8:00 AM - 10:00 AM', seatsAvailable: 4),
    TimeSlot(time: '10:00 AM - 12:00 PM', seatsAvailable: 3),
    TimeSlot(time: '12:00 PM - 2:00 PM', seatsAvailable: 4),
    TimeSlot(time: '2:00 PM - 4:00 PM', seatsAvailable: 4),
    TimeSlot(time: '4:00 PM - 6:00 PM', seatsAvailable: 3),
  ];

  final List<bool> _selected = List.generate(5, (index) => false);

  void _toggleSelection(int index) {
    setState(() {
      _selected[index] = !_selected[index];
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> _saveTimeSlots(List<TimeSlot> selectedTimeSlots) async {
    final user = _auth.currentUser;

    if (user != null) {
      //final userId = user.uid;
      final batch = _firestore.batch();

      for (final timeSlot in selectedTimeSlots) {
        final docRef = _firestore.collection('bookTimeSlot').doc();
        batch.set(docRef, {
          'userEmail': currentUser.email!,
          'time': timeSlot.time,
          'seatsAvailable': timeSlot.seatsAvailable,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      appBar: AppBar(
        title: Text('Time Slot Available'),
      ),

      body: ListView.builder(
        itemCount: _timeSlots.length,
        itemBuilder: (context, index) {
          final timeSlot = _timeSlots[index];
          return CheckboxListTile(
            title: Text(timeSlot.time),
            subtitle: Text('${timeSlot.seatsAvailable} time slot/s available'),
            value: _selected[index],
            onChanged: timeSlot.seatsAvailable > 0 ? (value) {
              _toggleSelection(index);
            } : null,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          final selectedTimeSlots = _timeSlots.where((slot) => _selected[_timeSlots.indexOf(slot)]).toList();
          if (selectedTimeSlots.isNotEmpty) {

            _saveTimeSlots(selectedTimeSlots); // Save selected time slots to Firestore
          } else {

            // Show an error message that no time slots were selected
          }
          // Handle the selected time slots here
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Booking confirmed'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('You have booked the following time slots:'),
                    SizedBox(height: 8),
                    ...selectedTimeSlots.map((slot) => Text(' ${slot.time}')),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                      // Update the seats available after booking
                      setState(() {
                        selectedTimeSlots.forEach((slot) {
                          final index = _timeSlots.indexOf(slot);
                          _timeSlots[index] = TimeSlot(
                            time: slot.time,
                            seatsAvailable: slot.seatsAvailable - 1,
                          );
                          _selected[index] = false;
                        });
                      });
                    },
                  ),
                ],
              );
            },
          );
        },
      ),

    );
  }




}




