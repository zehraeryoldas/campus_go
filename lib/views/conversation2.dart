import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/messageDetail.dart';
import 'package:campusgo/views/urunDetayMesajlasma.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'allAdsDetail.dart';

class Conversation extends StatefulWidget {
  const Conversation({Key? key});

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
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
                color: mainColor.color,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text(
                  "Sohbetler",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                Spacer(),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                    PopupMenuButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 1,
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          child: Text(
                            "Sohbeti Sil",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                          value: 1,
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 1) {
                          print("Sohbet silindi");
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .where("receiverId", isEqualTo: user)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading...');
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Text('No messages');
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    String receiverId = data['receiverId'].toString();
                    String senderId = user;
                    String message = data['message'].toString();
                    String product_id = data['product_id'].toString();
                    String images = data['images'].toString();
                    String user_name = data['user_name'].toString();
                    String product_name = data['product_name'].toString();
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessageDetail(
                                    userId: FirebaseAuth
                                        .instance.currentUser!.uid
                                        .toString(),
                                    postId: product_id.toString(),
                                    postUserId: receiverId.toString(),
                                    resim: images.toString(),
                                    user: user_name.toString(),
                                  )),
                        );
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 80,
                              child: CircleAvatar(
                                child: Image.network(images),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    user_name,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "RobotoCondensed",
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 80),
                                  child: Text(
                                    message,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0,
                                      fontFamily: "RobotoCondensed",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 80),
                            Column(
                              children: [
                                PopupMenuButton(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 1,
                                      child: Text("Sohbeti Sil"),
                                    ),
                                  ],
                                  onSelected: (value) {
                                    if (value == 1) {
                                      print("deleted");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
