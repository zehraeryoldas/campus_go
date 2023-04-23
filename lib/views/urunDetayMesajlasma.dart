// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/allAdsDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class urunDetayMesajlasma extends StatefulWidget {
  urunDetayMesajlasma({
    super.key,
    this.postUserId,
    this.user,
    this.resim,
    this.name,
    this.price,
    this.durum,
    this.aciklama,
    this.konum,
  });
  final String? postUserId;
  final String? user;
  final String? resim;
  final String? name;
  final int? price;
  final String? durum;
  final String? aciklama;
  final String? konum;

  @override
  State<urunDetayMesajlasma> createState() => _urunDetayMesajlasmaState();
}

class _urunDetayMesajlasmaState extends State<urunDetayMesajlasma> {
  TextEditingController messageController = TextEditingController();

  void messageAdded(String text) {
    setState(() {
      FirebaseFirestore.instance.collection("chats").add({
        'message': text,
        'timeStamp': DateTime.now(),
        'senderId': FirebaseAuth.instance.currentUser!.uid,
        'user_name': widget.user,
        'receiverId': widget.postUserId
      });
      messageController.text = "";
    });
  }
  // ignore: non_constant_identifier_names

  // var mesajlarListesi = <String>[];

  // void _handleSubmitted(String text) {
  //   messageController.clear();
  //   mesajlarListesi.add(text);
  // }

  // Widget _buildTextComposer() {
  //   return Container(
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         Flexible(
  //           child: TextField(
  //             controller: messageController,
  //             onSubmitted: _handleSubmitted,
  //             decoration: InputDecoration.collapsed(hintText: 'Send'),
  //           ),
  //         ),
  //         IconButton(
  //             onPressed: () {
  //               _handleSubmitted(messageController.text);
  //             },
  //             icon: Icon(Icons.send))
  //       ],
  //     ),
  //   );
  //}

  @override
  Widget build(BuildContext context) {
    final String userId = "pceXDyA3HagfmzQ8vyXw8vokOaz1";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllAdsDetailPage(
                            resim: widget.resim,
                            name: widget.name,
                            price: widget.price,
                            durum: widget.durum,
                            aciklama: widget.aciklama,
                            konum: widget.konum,
                            user: widget.user,
                          )));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Row(
          children: [
            SizedBox(
                width: 50,
                height: 50,
                child: Image.network(widget.resim.toString())),
            Expanded(
                child: ListTile(
              title: Text(
                widget.user.toString(),
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                widget.name.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ))
          ],
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.call,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ))
            ],
          )
        ],
      ),
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: ListView.builder(
      //           itemCount: 10,
      //           itemBuilder: ((context, index) {
      //             return ListTile(
      //               title: Align(
      //                   alignment: index % 2 == 0
      //                       ? Alignment.centerLeft
      //                       : Alignment.centerRight,
      //                   child: Container(
      //                     padding: EdgeInsets.all(8),
      //                     decoration: BoxDecoration(
      //                         color: Colors.yellow,
      //                         borderRadius: BorderRadius.horizontal(
      //                             left: Radius.circular(10),
      //                             right: Radius.circular(10))),
      //                     child: Text("Deneme mesajı"),
      //                   )),
      //             );
      //           })),
      //     ),
      //     Row(
      //       children: [
      //         Expanded(
      //             child: Container(
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.horizontal(
      //                         left: Radius.circular(25),
      //                         right: Radius.circular(25))),
      //                 child: Row(
      //                   children: [
      //                     Expanded(
      //                       child: TextField(
      //                         decoration: InputDecoration(hintText: "Mesaj"),
      //                       ),
      //                     ),
      //                    IconButton(onPressed: (){}, icon: Icon(Icons.send))
      //                   ],
      //                 )))
      //       ],
      //     )
      //   ],
      // ),

      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .where("senderId",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error : ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            }
            return Column(children: [
              Expanded(
                child: ListView(
                  children: snapshot.data!.docs
                      .map((doc) => ListTile(
                            title: Text(doc['message']),
                          ))
                      .toList(),
                ),
              ),
              Divider(
                thickness: 3,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(25),
                                  right: Radius.circular(25))),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onSubmitted: messageAdded,
                                  decoration:
                                      InputDecoration(hintText: "Mesaj"),
                                  controller: messageController,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    messageAdded(messageController.text);
                                  },
                                  icon: Icon(Icons.send))
                            ],
                          )))
                ],
              )
            ]);
          }),
    );
  }
}
