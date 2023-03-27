// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, avoid_print

import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/myAds.dart';
import 'package:campusgo/views/myFavs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class adsPage extends StatefulWidget {
  @override
  State<adsPage> createState() => _adsPageState();
}

class _adsPageState extends State<adsPage> {
  CollectionReference sneakers =
      FirebaseFirestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(tabs: [
              Tab(
                  child: Text(
                    "İlanlarım",
                    style: TextStyle(color: mainColor.color),
                  ),
                  icon: Icon(Icons.ads_click,
                      color: mainColor.color)),
              Tab(
                  child: Text("Favorilerim",
                      style:
                          TextStyle(color: mainColor.color)),
                  icon: Icon(
                    Icons.favorite,
                    color: mainColor.color,
                  )),
            ]),
          ),
          body: TabBarView(
            children: [
              ilanlarim(),
              favorilerim(),
            ],
          ),
        ),
      ),
    );
  }
}




