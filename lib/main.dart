import 'dart:io';

import 'package:campusgo/arayuz.dart';
import 'package:campusgo/firebase_options.dart';
import 'package:campusgo/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            tabBarTheme: TabBarTheme(
              labelColor: Colors.pink,
              unselectedLabelColor: Colors.red,
            ),
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.transparent, elevation: 0.0)),
        debugShowCheckedModeBanner: false,
        title: "campusGo",

        //home: UserLogin(),
        // home:
        //           signIn.currentUser!.emailVerified ? girisSayfasi() : AnaEkran(),
        home: _buildBody());
  }

  Widget _buildBody() {
    if (FirebaseAuth.instance.currentUser != null) {
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        return UserLogin();
      } else {
        return Arayuz();
      }
    } else {
      return UserLogin();
    }
  }
}
