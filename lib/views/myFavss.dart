import 'package:campusgo/services/favourite_service.dart';
import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/allAdsDetail.dart';
import 'package:campusgo/views/myFavsDEtailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // dart:async kütüphanesini içe aktar

// Diğer kodlarınız


class favorilerim extends StatefulWidget {
  @override
  State<favorilerim> createState() => _favorilerimState();
}

class _favorilerimState extends State<favorilerim> {
  final _userStream = FirebaseFirestore.instance
      .collection("favorite")
      .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      // .where('status', isEqualTo: 1)
      .where('productss.isFav', isEqualTo: true)
      //.where("productss.numberOfLikes", isEqualTo: 1)
      .snapshots();


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _userStream,
        builder:
            ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('hatalı işlem');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data!.docs[index];
              String id=data['id'].toString();
              String post_id = data['post_id']!.toString();

              String postUserId = data['post_user_id']!;
              String resim = data['productss.images'].toString();
              String name = data['productss.name'].toString();
              int price = data['productss.price'];
              String durum = data['productss.status'];
              String aciklama = data['productss.description'];
              String konum = data['productss.location'];
              String kategori = data['productss.category_id'];
              String user = data['productss.user.name'].toString();
              bool isFav = data['productss.isFav'];
              // String userId = data['user_id'].toString();
              print("????????");
              print(data['productss.isFav']);
              print("******");
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyFavsDEtailPage(
                              id: postUserId,
                              idx: post_id,
                              resim: resim,
                              name: name,
                              price: price,
                              durum: durum,
                              aciklama: aciklama,
                              konum: konum,
                              user: user)));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  child: Row(children: [
                    Card(
                      child: Container(
                        //color: Colors.red,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(resim.toString()))),
                        width: MediaQuery.of(context).size.width * 0.40,
                        height: MediaQuery.of(context).size.height * 0.12,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 40,
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: ListTile(
                          title: Text(price.toString() + " \u20ba",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontFamily: "RobotoCondensed")),
                          subtitle: Text(name,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "RobotoCondensed")),
                          trailing: isFav
                              ? IconButton(
                                  onPressed: () async{
                                   await FirebaseFirestore.instance
                                        .collection("favorite")
                                        .doc(id)
                                        .update({'productss.isFav': false});
                                        FirebaseFirestore.instance.collection("products")
                                        .where('name',)
                                        .get()
                                        .then((value){
                                          value.docs.forEach((document) {
                                            document.reference
                                            .update({'isFav':false});
                                          });
                                        });
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: mainColor.color,
                                  ))
                              :IconButton(
                                  onPressed: () async {
                                    print("0000000");
                                     print("0000000");
                                   await FirebaseFirestore.instance
                                        .collection("favorite")
                                        .doc(id)
                                        .update({'productss.isFav': true});
                                         FirebaseFirestore.instance.collection("products")
                                        .where('name',isEqualTo: data['name'])
                                        .get()
                                        .then((value){
                                          value.docs.forEach((document) {
                                            document.reference
                                            .update({'isFav':true});
                                          });
                                        });
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                  )),
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            },
          );
        }));
  }
}
