import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrubb/components/dateNtimeButton.dart';
import 'package:scrubb/Payment/cashPayment.dart';
import 'package:scrubb/timeSlot.dart';
import '../components/ProceedButton.dart';
import '../Payment/payment.dart';


class selectionHousek extends StatefulWidget {

  final Function()?onTap;
  const selectionHousek({Key? key, required this.onTap}) : super(key: key);

  @override
  State<selectionHousek> createState() => _selectionHousekState();
}

class _selectionHousekState extends State<selectionHousek> {

  DateTime date = DateTime.now();
  final currentUser = FirebaseAuth.instance.currentUser!;
  //text controller
  final nameTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final notesTextController = TextEditingController();


  //dispose
  @override void dispose(){
    nameTextController.dispose();
    phoneTextController.dispose();
    addressTextController.dispose();
    notesTextController.dispose();
    super.dispose();
  }

  void addAppointment()async {
    addBookingDetails(
      nameTextController.text.trim(),//trim()
      phoneTextController.text.trim(),
      addressTextController.text.trim(),
      notesTextController.text.trim(),
      date,
    );
    Navigator.push(context, MaterialPageRoute(builder: (context)=> payment(),
    ),);
  }

  Future addBookingDetails(String name, String phone, String address, String notes, DateTime newDate) async {
    await FirebaseFirestore.instance.collection('Housekeeping_bookings').add({
      'Email': currentUser.email,
      'Name':name,
      'Phone No':phone,
      'Address':address,
      'Special Notes':notes,
      'Date': newDate,
    });
  }


  //save date
  void _selectDate() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );

    if(newDate == null) return;
    setState(() => date = newDate
    );

    //if (newDate != null) {
    //  FirebaseFirestore.instance
    //      .collection('Commercial_bookings')
    //      .add({'date': newDate});
    // }

  }

  void _selectTime() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>timeSlot(),
      ),);
  }

  //AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      appBar: AppBar(
        title: Text('Booking a service'),
      ),

      body: Container(
        height: 760,
        child:SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15),

              //display service chosen and the price

              Container(
                height:155,
                width:380,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Text('Email: ' + currentUser.email!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    ),
                    SizedBox(height: 15),
                    Text('You have chosen:', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)
                    ),
                    Text('Housekeeping Service', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                    SizedBox(height: 12),
                    Text('Price:', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)
                    ),
                    Text('RM 110', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),



              //display chosen date *********************************

              Text('Date of your cleaning service:',textAlign: TextAlign.left, style: TextStyle(fontSize: 15),
              ),
              Text('${date.day}/${date.month}/${date.year}', textAlign: TextAlign.left, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: dateNTimeButton(
                    onTap: _selectDate,
                    text: 'Choose Date'),
              ),

              SizedBox(height: 25),

              //display chosen time *************************************

              Text('Time Slot of your cleaning service:',textAlign: TextAlign.left, style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: dateNTimeButton(
                    onTap: _selectTime,
                    text: 'Choose Time Slot'),
              ),

              SizedBox(height: 15),

              //FILL INFO
              //Client details (name, phone no, address) ********************************
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  // the expanded function in notepad++ note2

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: nameTextController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        labelText: "Name",
                        labelStyle: TextStyle(fontSize: 16,color: Colors.black
                        ),
                        border: OutlineInputBorder(),
                        fillColor: Colors.grey[300],
                      ),
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: phoneTextController,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        labelText: "Phone Number",
                        labelStyle: TextStyle(fontSize: 16,color: Colors.black
                        ),
                        border: OutlineInputBorder(),
                        fillColor: Colors.grey[300],
                      ),
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: addressTextController,
                      decoration: InputDecoration(
                        hintText: "Address",
                        labelText: "Address",
                        labelStyle: TextStyle(fontSize: 16,color: Colors.black
                        ),
                        border: OutlineInputBorder(),
                        fillColor: Colors.grey[300],
                      ),
                      keyboardType: TextInputType.streetAddress,
                      maxLines: 3,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: notesTextController,
                      decoration: InputDecoration(
                        hintText: "Special Note to Worker",
                        labelText: "Special Note to Worker",
                        labelStyle: TextStyle(fontSize: 16,color: Colors.black
                        ),
                        border: OutlineInputBorder(),
                        fillColor: Colors.grey[300],
                      ),
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                    ),
                  ),



                  SizedBox(height: 8),

                  //proceed to payment page and there is a button here ********************************

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ProceedButton(
                        onTap: addAppointment,
                        text: 'Proceed to Payment'),
                  ),

                ],),

            ],
          ),
        ),),



    );

  }
}

