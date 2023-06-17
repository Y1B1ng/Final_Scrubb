import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scrubb/components/ProceedButton.dart';
import 'package:scrubb/ServicesPages/userResBookings.dart';
import 'package:scrubb/ServicesPages/userCommBookings.dart';
import 'package:scrubb/ServicesPages/userHouseBookings.dart';
import 'package:scrubb/ServicesPages/userPRenoBookings.dart';


class bookingStatus extends StatefulWidget {
  const bookingStatus({Key? key}) : super(key: key);

  @override
  State<bookingStatus> createState() => _bookingStatusState();
}

class _bookingStatusState extends State<bookingStatus> {

  final currentUser = FirebaseAuth.instance.currentUser!;


  Future UserResidentialBookingsList()async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>userResBookings(),
      ),);
  }

  Future UserCommercialBookingList()async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>userCommBookings(),
      ),);
  }

  Future UserHousekeepingBookingList()async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>userHouseBookings(),
      ),);
  }

  Future UserPostRenovationBookingList()async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>userPRenoBookings(),
      ),);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      appBar: AppBar(
        title: Text('Booking Status'),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Residential Bookings' ,
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300
                    ),),
                  const SizedBox(height: 6),

                  ProceedButton(
                      onTap: UserResidentialBookingsList,
                      text: 'Residential service'),
                ],
              ),

              SizedBox(height: 30),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Commercial Bookings',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300
                    ),),
                  const SizedBox(height: 6),

                  ProceedButton(
                      onTap: UserCommercialBookingList,
                      text: 'Commercial service'),
                ],
              ),

              SizedBox(height: 30),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Housekeeping Bookings',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300
                    ),),
                  const SizedBox(height: 6),

                  ProceedButton(
                      onTap: UserHousekeepingBookingList,
                      text: 'Housekeeping service'),
                ],
              ),

              SizedBox(height: 30),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Post Renovation Bookings',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300
                    ),),
                  const SizedBox(height: 6),

                  ProceedButton(
                      onTap: UserPostRenovationBookingList,
                      text: 'Post Renovation service'),
                ],
              ),


            ],
          ),
        ),
      ),

    );
  }
}
