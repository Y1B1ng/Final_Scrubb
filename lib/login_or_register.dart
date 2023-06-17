import 'package:flutter/material.dart';
import 'package:scrubb/Pages/login.dart';
import 'package:scrubb/Pages/register.dart';


class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially, show the login page
  bool showLoginPage = true;

  //toggle between
  void togglePages (){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override

  Widget build(BuildContext context) {
    if (showLoginPage){
      return login(onTap: togglePages);
    }else{
      return registerPage(onTap:togglePages);
    }
  }
}

