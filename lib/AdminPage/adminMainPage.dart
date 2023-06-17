import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scrubb/AdminPage/commBookList.dart';
import 'package:scrubb/AdminPage/loginAdmin.dart';
import 'package:scrubb/components/ProceedButton.dart';
import 'package:scrubb/AdminPage/customerList.dart';
import 'package:scrubb/AdminPage/houseBookList.dart';
import 'package:scrubb/AdminPage/postRenoBookList.dart';
import 'package:scrubb/AdminPage/residentBookList.dart';


class adminMainPage extends StatefulWidget {
  const adminMainPage({Key? key}) : super(key: key);

  @override
  State<adminMainPage> createState() => _adminMainPageState();
}

class _adminMainPageState extends State<adminMainPage> {

  //final currentUser = FirebaseAuth.instance.currentUser!;

  //void signOut(){
   // FirebaseAuth.instance.signOut();
  //}
  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => loginAdmin(),
      ),
    );
  }

  Future CustomerListPage()async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>CustomerList(),
      ),);
  }

  Future CommercialBookingListPage()async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>commBookList(),
      ),);
  }

  Future HousekeepingBookingListPage()async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>houseBookList(),
      ),);
  }

  Future PostRenovationBookingListPage()async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>postRenoBookList(),
      ),);
  }

  Future ResidentialBookingListPage()async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>residentBookList(),
      ),);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      appBar: AppBar(
        title: Text('ADMIN Main Page'),
        backgroundColor: Color(0xffd6b738),
        actions: [
          IconButton(
           // onPressed: logout,
            onPressed: () {
              logout(context);},
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              //Text('Admin logged in as: ' + currentUser.email!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              SizedBox(height: 30),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('List of Registered User' ,
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300
                    ),),
                  const SizedBox(height: 6),

                  ProceedButton(
                      onTap: CustomerListPage,
                      text: 'users'),
                ],
              ),

              SizedBox(height: 30),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('List of Commercial Bookings',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300
                      ),),
                      const SizedBox(height: 6),

                      ProceedButton(
                          onTap: CommercialBookingListPage,
                          text: 'Commercial service'),
                    ],
                  ),

              SizedBox(height: 30),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('List of Housekeeping Bookings',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300
                    ),),
                  const SizedBox(height: 6),

                  ProceedButton(
                      onTap: HousekeepingBookingListPage,
                      text: 'Housekeeping service'),
                ],
              ),

              SizedBox(height: 30),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('List of Post Renovation Bookings',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300
                    ),),
                  const SizedBox(height: 6),

                  ProceedButton(
                      onTap: PostRenovationBookingListPage,
                      text: 'Post Renovation service'),
                ],
              ),

              SizedBox(height: 30),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('List of Residential Bookings',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300
                    ),),
                  const SizedBox(height: 6),

                  ProceedButton(
                      onTap: ResidentialBookingListPage,
                      text: 'Residential service'),
                ],
              ),

            ],
          ),
        ),
      ),

    );
  }
}
