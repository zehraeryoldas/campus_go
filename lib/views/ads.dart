// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, avoid_print

import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/myAds.dart';
import 'package:campusgo/views/myFavss.dart';
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
            title: Text("CampusGo",style: TextStyle(fontSize: 20,color: mainColor.color,fontWeight: FontWeight.w500),),
            backgroundColor: Colors.white,
            bottom: TabBar(
              //overlayColor: MaterialStateProperty.all(Colors.red),
              unselectedLabelColor: Colors.grey,
              indicatorColor: mainColor.color,
              labelColor: mainColor.color,
              tabs: [
              Tab(
                  child: Text(
                    "İlanlarım",
                    //style: TextStyle(color: mainColor.color),
                  ),
                  icon: Icon(Icons.ads_click,
                      color: mainColor.color)),
              Tab(
                  child: Text("Favorilerim",
                      // style:
                      //     TextStyle(color: mainColor.color)
                          ),
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




