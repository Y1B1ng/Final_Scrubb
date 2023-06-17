import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrubb/text_field.dart';
import '../components/loginButton.dart';

class registerPage extends StatefulWidget {
  final Function()?onTap;
  const registerPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  //text editing controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmedPasswordTextController = TextEditingController();

  @override void dispose(){
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmedPasswordTextController.dispose();
    super.dispose();
  }


  //sign up
  void signUp() async {

    //show loading
    showDialog(
      context: context,
      builder: (context)=> const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //make sure confirm password match
    if (passwordTextController.text != confirmedPasswordTextController.text){
      Navigator.pop(context);
      displayMessage("Passwords did not match");
      return;
    }

    //create the user
    try{
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text,);

      //after creating the user, create a new document
      FirebaseFirestore.instance.collection("Users")
      .doc(userCredential.user!.email)
      .set({
        'username':emailTextController.text.split('@')[0], //initial username
        'uid': userCredential.user!.uid
      });

      if (mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      displayMessage(e.code);
    }
   }


    //add user details
    //addUserDetails(
    //    emailTextController.text.trim(),
   // );



    //Future addUserDetails(String email)async {
    //await FirebaseFirestore.instance.collection('users').add({
    //  'Email':email,
   // });
   // }

  //display a dialog message
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text(message),
      ),
    );
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
                const SizedBox(height:15),

                Text(
                  'User Sign Up',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height:18),

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

                text_field(
                    controller: confirmedPasswordTextController,
                    hintText: 'Confirm Password',
                    obscureText: true),

                const SizedBox(height:20),

                MyButton(
                    onTap: signUp,
                    text: 'Sign Up'),

                const SizedBox(height:10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    const SizedBox(width: 4),

                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Log in here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
