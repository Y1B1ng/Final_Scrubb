import 'package:flutter/material.dart';

class AdminLoginButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const AdminLoginButton({Key? key, required this.onTap, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color:Color(0xffffd451),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),

      ),
    );
  }
}
