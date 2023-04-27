import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/allAdsDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class category extends StatefulWidget {
  const category({super.key});

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {
  var _categoryStream =
      FirebaseFirestore.instance.collection("category").snapshots();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _categoryStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loadingg...');
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot data = snapshot.data!.docs[index];

            return GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllAdsDetailPage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(18)),
                  elevation: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        data['name'],
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18.0,
                            fontFamily: "RobotoCondensed"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
