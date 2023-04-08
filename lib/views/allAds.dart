import 'package:campusgo/models/favourite_model.dart';
import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/allAdsDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/favourite_service.dart';

class allAds extends StatefulWidget {
  const allAds({
    super.key,
  });
  @override
  State<allAds> createState() => _ilanlarimState();
}

class _ilanlarimState extends State<allAds> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('productss')
      .where("productStatus", isEqualTo: 1)
      .where('user.userStatus', isEqualTo: 1)
      .snapshots();

  int favouriteValue = 0;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _usersStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return GridView.builder(
          itemCount: snapshot.data!.docs.length,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            DocumentSnapshot data = snapshot.data!.docs[index];
            String postUserId = data['userId'].toString();
            String postId = data['id'].toString();
            String resim = data['images'].toString();
            String name = data['name'].toString();
            int price = data['price'];
            String durum = data['status'];
            String aciklama = data['description'];
            String konum = data['location'];
            String user = data['user.name'].toString();
            bool isFav = data['isFav'];
            //bool productStatus = data['productStatus'];

            return GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllAdsDetailPage(
                              id: postUserId,
                              price: price,
                              name: name,
                              resim: resim,
                              durum: durum,
                              aciklama: aciklama,
                              konum: konum,
                              user: user,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.0, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(18)),
                  elevation: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(children: [
                        Container(
                          //color: mainColor.color,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(data['images'].toString()),
                              )),
                          width: MediaQuery.of(context).size.width * 0.80,
                          height: MediaQuery.of(context).size.height * 0.16,
                        ),
                        Positioned(
                          left: 120,
                          bottom: 90,
                          child: isFav
                              ? IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("productss")
                                        .doc(postId)
                                        .update({
                                      'isFav': false,
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: mainColor.color,
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("productss")
                                        .doc(postId)
                                        .update({
                                      'isFav': true,
                                    });
                                    if (postUserId !=
                                        FirebaseAuth
                                            .instance.currentUser!.uid) {
                                      favouriteService().addFavourite(
                                        postId,
                                        postUserId,
                                        1,
                                        FirebaseAuth.instance.currentUser!.uid,
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                  ),
                                ),
                        )
                      ]),
                      Text(
                        data['name'],
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18.0,
                            fontFamily: "RobotoCondensed"),
                      ),
                      Text(
                        data['price'].toString() + "\u20ba",
                        style: TextStyle(
                            color: mainColor.color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
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
