import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrubb/AdminPage/adminMainPage.dart';
import 'package:scrubb/components/loginButton.dart';
import '../Pages/login.dart';
import 'package:get/get.dart';
import '../text_field.dart';

class loginAdmin extends StatefulWidget {

  const loginAdmin({Key? key}) : super(key: key);

  @override
  State<loginAdmin> createState() => _loginAdminState();
}

class _loginAdminState extends State<loginAdmin> {
  //text editing controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  //sign user in
  void signIn() async {
    //show loading
    showDialog(
      context: context,
      builder: (context) =>
      const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //sign in purpose

    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: emailTextController.text,
    //     password: passwordTextController.text,
    await FirebaseFirestore.instance.collection("Admin")
        .doc("AdminLogin")
        .snapshots()
        .forEach((element) {
      if (element.data()?['AdminEmail'] == emailTextController.text &&
          element.data()?['AdminPassword'] == passwordTextController.text) {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => adminMainPage()), (
            route) => false);
      }
    }).catchError((e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(title: Text("Error Meassage"),
              content: Text(e.toString()),
            );
          });
    });
    //pop the loading


    //display a dialog message
  //  void displayMessage(String message) {
   //   showDialog(
   //     context: context,
   //     builder: (context) =>
    //        AlertDialog(
   //           title: Text(message),
   //         ),
   //   );
   // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffd451),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
                'SCRUBB',
                style: TextStyle(
                    color: Color(0xff540d6e),
                    fontSize: 45,
                    fontWeight: FontWeight.bold
                ),
              ),

              Text(
                'Home Cleaning Services',
                style: TextStyle(
                    color: Color(0xff540d6e),
                    fontSize: 22,
                    fontWeight: FontWeight.normal
                ),
              ),
              const SizedBox(height:20),

              Text(
                'Admin Log In',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
                const SizedBox(height:20),

                text_field(
                    controller: emailTextController,
                    hintText: 'Email',
                    obscureText: false),

                const SizedBox(height:20),

                text_field(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obscureText: true),
                
                const SizedBox(height:20),
                
                MyButton(
                    onTap: signIn,
                   text: 'Log In'),


                const SizedBox(height:20),


            ],
        ),
          ),
        ),
      ),
    );
  }
}
