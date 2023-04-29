// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/category.dart';
import 'package:campusgo/views/productSearch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../arayuz.dart';
import 'allAdss.dart';
//import 'allAds.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final locationIdController = TextEditingController();

  TextEditingController userIdController = TextEditingController();

  CollectionReference location =
      FirebaseFirestore.instance.collection("location");
  String? dropdownValue1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CampusGo",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: mainColor.color),
        ),
        bottom: PreferredSize(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: _search(context)),
            preferredSize: Size.fromHeight(30)),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notification_add),
                color: mainColor.color,
              )
            ],
          )
        ],
      ),
      //body: conversationPage(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 220),
            child: Text("Kategorilere göz at..",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
          ),
         SizedBox(height: 130,child: Expanded(child: category())),
          Expanded(child: allAds()),
        ],
      ),
    );
  }

  SizedBox _myCategoriesCard(Icon icon) {
    return SizedBox(
      width: 100,
      height: 50,
      child: Card(
        child: IconButton(onPressed: () {}, icon: icon),
      ),
    );
  }

  TextButton _search(BuildContext context) {
    return TextButton.icon(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black26)))),
        onPressed: () {
          showSearch(context: context, delegate: searchDelegate());
        },
        icon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        label: const Text(
          "Kitap, defter vb.",
          style: TextStyle(
            color: Colors.grey,
          ),
        ));
  }

  StreamBuilder<QuerySnapshot<Object?>> _location() {
    return StreamBuilder<QuerySnapshot>(
        stream: location.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return Container(
            width: double.infinity,
            child: DropdownButton<String>(
              hint: Text("Konum Seç"),
              onChanged: (String? newValue) {
                setState(() {
                  //locationIdController.text = newValue!;
                  dropdownValue1 = newValue;
                });
              },
              value: dropdownValue1,
              items: snapshot.data!.docs.map((DocumentSnapshot doc) {
                return DropdownMenuItem(
                  alignment: Alignment.bottomCenter,
                  child: Text(doc['name']),
                  value: doc.reference.id.toString(),
                );
              }).toList(),
            ),
          );
        });
  }
}
