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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                _logoText(),
              ],
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
                //overlayColor: MaterialStateProperty.all(Colors.red),
                unselectedLabelColor: Colors.grey,
                indicatorColor: mainColor.color,
                labelColor: mainColor.color,
                tabs: [
                  _myTab("İlanlarım",
                      Icon(Icons.ads_click, color: mainColor.color)),
                  _myTab(
                      "Favorilerim",
                      Icon(
                        Icons.favorite,
                        color: mainColor.color,
                      ))
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

  Text _logoText() {
    return Text(
      "CampusGo",
      style: TextStyle(
          fontSize: 20, color: mainColor.color, fontWeight: FontWeight.w500),
    );
  }

  Tab _myTab(String text, Icon icon) {
    return Tab(
        child: Text(text
            //style: TextStyle(color: mainColor.color),
            ),
        icon: icon);
  }
}
