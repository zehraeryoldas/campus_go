import 'dart:io';

import 'package:campusgo/arayuz.dart';
import 'package:campusgo/firebase_options.dart';
import 'package:campusgo/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   if (kIsWeb) {
//     await Firebase.initializeApp(
//         options: const FirebaseOptions(
//       apiKey: "AIzaSyCjkrK5yQx7JibDDh33sHkhgC8vqGsr9E8",
//       projectId: "campusgo-fc19b",
//       messagingSenderId: "632531570660",
//       appId: "1:632531570660:web:331e3e352d88fab6d201f1",
//     ));
//   } else {
//     await Firebase.initializeApp();
//   }
//   runApp(MyApp());
// }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      //   options: const FirebaseOptions(
      //   apiKey: 'AIzaSyAjqBHlBRhxUYpMq92kfMk8zsxzW7xFDcY',
      //  projectId: 'campusgo-6eec2',
      //   storageBucket: 'campusgo-6eec2.appspot.com',
      //   messagingSenderId: '898695960774',
      //   appId: '1:898695960774:web:a7a21c5caf34fabb331fc7',
      // )
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
          appBarTheme:
              AppBarTheme(backgroundColor: Colors.transparent, elevation: 0.0)),
      debugShowCheckedModeBanner: false,
      title: "campusGo",

      //home: UserLogin(),
      // home:
      //           signIn.currentUser!.emailVerified ? girisSayfasi() : AnaEkran(),
      home: FirebaseAuth.instance.currentUser!.emailVerified
          ? UserLogin()
          : Arayuz(),
    );
  }
}
