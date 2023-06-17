import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrubb/Pages/home.dart';
import 'package:scrubb/login_or_register.dart';
import 'main.dart';

class authPage extends StatelessWidget {
  const authPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot) {
          //user logged in
          if(snapshot.hasData){
            return bottomBarNavi();
          }
          //user NOT logged in
          else{
            return const LoginOrRegister();
          }

        },
      ),
    );
  }
}
