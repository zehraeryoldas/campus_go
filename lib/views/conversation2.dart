import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/urunDetayMesajlasma.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'allAdsDetail.dart';

class conversation extends StatefulWidget {
  const conversation({super.key});

  @override
  State<conversation> createState() => _conversationState();
}

class _conversationState extends State<conversation> {
  String user = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 280, top: 30),
            child: Text(
              "CampusGo",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: mainColor.color),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Row(
              children: [
                Text("Sohbetler",
                    style: TextStyle(color: Colors.black, fontSize: 22)),
                Spacer(),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                    PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      elevation: 1,
                      icon: Icon(Icons.more_vert),
                      itemBuilder: ((context) => [
                            const PopupMenuItem(
                              child: Text("Sohbeti Sil",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22)),
                              value: 1,
                            )
                          ]),
                      onSelected: ((value) {
                        if (value == 1) {
                          print("Sohbet silindi");
                        }
                      }),
                    )
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .where("receiverId", isEqualTo: user).limit(1)
                  .snapshots(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        String receiverId = data['receiverId'].toString();
                        String senderId = user;
                        String message = data['message'].toString();
                        String product_id = data['product_id'].toString();
                        String images = data['images'].toString();
                        String user_name=data['name'].toString();
                        

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => urunDetayMesajlasma(
                                          postId: receiverId,
                                          resim: images,
                                          user: user_name,
                                          userId: senderId,
                                          postUserId: receiverId,
                                          
                                        )));
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.0),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: 60,
                                    height: 80,
                                    child: CircleAvatar(
                                      child: Image.network(
                                          data['images'].toString()),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        data['name'].toString(),
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "RobotoCondensed"),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 100),
                                      child: Text(
                                        data['message'].toString(),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18.0,
                                            fontFamily: "RobotoCondensed"),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                Column(
                                  children: [
                                    // Text(data['name'].toString(),style: TextStyle(
                                    //   color: Colors.grey
                                    // ),),
                                    PopupMenuButton(
                                      itemBuilder: ((context) => [
                                            PopupMenuItem(
                                                value: 1,
                                                child: Text("Sohbeti Sil")),
                                          ]),
                                      onSelected: (value) {
                                        if (value == 1) {
                                          print("deleted");
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
                );
              }))
        ],
      ),
    );
  }
}
