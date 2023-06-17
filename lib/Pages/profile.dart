import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrubb/ServicesPages/bookingStatus.dart';
import 'package:scrubb/Pages/customerHotline.dart';
import 'package:scrubb/login_or_register.dart';
import 'package:scrubb/Pages/privacyPolicy.dart';
import 'package:scrubb/Pages/termsNconditions.dart';
import 'package:scrubb/text_box.dart';


class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {

  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  //all users
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  //for edit part
  Future<void> editField (String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text("Edit $field",
          style: TextStyle(color: Colors.white),
        ),
          content: TextField(
            autofocus: true,
          style: TextStyle(color:Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
            onChanged: (value){
              newValue = value;
            },
      ),
        actions: [
          //cancel button
          TextButton(
            child: Text('Cancel',style: TextStyle(color: Colors.white),
            ),
            onPressed: ()=> Navigator.pop(context),
          ),

          //save button
          TextButton(
            child: Text('Save',style: TextStyle(color: Colors.white),
            ),
            onPressed: ()=> Navigator.of(context).pop(newValue),
          ),

        ],
      ),
    );

    //update in firestore
    if (newValue.trim().length>0){
      //only update if there is something in the textfield
      await usersCollection.doc(currentUser.email).update({field:newValue});
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xffd6b738),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users")
        .doc(currentUser.email)
        .snapshots(),
        builder: (context,snapshot){
          //get usr data
          if(snapshot.hasData){
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              children: [
                //profile pic
                const SizedBox(height:20),
                const Icon(
                  Icons.person, size: 70,
                ),

                const SizedBox(height: 15),

                //user email
                Text('Email logged in as: ' + currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[800]),
                ),
                const SizedBox(height: 10),

                //username
                textBox(
                  text: userData['username'],
                  sectionName: 'username',
                  onPressed: ()=> editField('username'),
                ),


                const SizedBox(height: 40),

                profileMenu(title: "Booking Status",icon: Icons.fact_check, onPress: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>bookingStatus(),
                    ),);
                },),

                profileMenu(title: "Term and Conditions",icon: Icons.settings, onPress: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>termsNconditions(),
                    ),);
                },),

                profileMenu(title: "Privacy Policy",icon: Icons.privacy_tip, onPress: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>privacyPolicy(),
                    ),);
                },),

                profileMenu(title: "Customer Hotline",icon: Icons.support_agent, onPress: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>customerHotline(),
                    ),);
                },),

                SizedBox(height: 10),

              ],
            );
          } else if (snapshot.hasError){
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }
          return const Center(child: CircularProgressIndicator()
          );

      },
      ),

      //list of button (profile page)







    );

  }
}

class profileMenu extends StatelessWidget {
  const profileMenu({
    Key? key,
    required this.title,
    required this.icon,
    //this.iconColor,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
 // final Color? iconColor;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        padding: const EdgeInsets.all(22),
        height: 30, width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffd6b738),

        ),

      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
      trailing: endIcon? Container(
        height: 30, width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
        ),
        child: Icon(Icons.arrow_right,color: Colors.grey),
      ):null,

    );
  }
}


