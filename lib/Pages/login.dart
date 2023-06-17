import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrubb/components/AdminLoginButton.dart';
import 'package:scrubb/AdminPage/loginAdmin.dart';
import 'package:scrubb/components/loginButton.dart';
import '../forgotPassword.dart';
import 'register.dart';
import 'package:get/get.dart';
import '../text_field.dart';

class login extends StatefulWidget {
  final Function()? onTap;
  const login({Key? key, required this.onTap }) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  //text editing controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  //sign user in
  void signIn() async {
    //show loading
    showDialog(
      context: context,
      builder: (context)=> const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //sign in purpose
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      //pop the loading
      if (mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading
      Navigator.pop(context);
      //error message
      displayMessage(e.code);
    }
  }

  //display a dialog message
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text(message),
      ),
    );
  }

  Future AdminLogin()async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>loginAdmin(),
      ),);
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
                  'User Log In',
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

                const SizedBox(height:18),

                text_field(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obscureText: true),

                const SizedBox(height:5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return ForgotPasswordPage();
                                },
                              ),
                          );
                        },
                        child: Text('Forgot Password?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height:15),

                MyButton(
                    onTap: signIn,
                    text: 'Log In'),
                const SizedBox(height:10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not yet register an account?'),
                    const SizedBox(width: 4),

                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Register now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),


                //For admin login
                const SizedBox(height:20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('For Admin'),
                    const SizedBox(width: 4),

                    AdminLoginButton(
                        onTap: AdminLogin,
                        text: 'Log in here'),
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
