import 'package:campusgo/utility/color.dart';
import 'package:campusgo/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    return await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    (MaterialPageRoute(builder: (context) => UserLogin())));
              },
              icon: Icon(
                Icons.exit_to_app,
                color: mainColor.color,
              ))
        ],
      ),
    );
  }
}
