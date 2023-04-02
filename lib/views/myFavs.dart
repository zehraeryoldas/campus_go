import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/allAdsDetail.dart';
import 'package:campusgo/views/myFavsDEtailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class favorilerim extends StatefulWidget {
  @override
  State<favorilerim> createState() => _favorilerimState();
}

class _favorilerimState extends State<favorilerim> {
  final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance
      .collection("productss")
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('productStatus', isEqualTo: 1)
      .where('user.userStatus', isEqualTo: 1)
      .where('numberOfLikes', isEqualTo: 1)
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
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              String idx = data['id']!.toString();

              String id = data['userId']!;
              String resim = data['images'].toString();
              String name = data['name'].toString();
              int price = data['price'];
              String durum = data['status'];
              String aciklama = data['description'];
              String konum = data['location'];
              String kategori = data['category_id'];
              String user = data['user.name'].toString();
              String postUserId = data['userId'].toString();
              print("******");
              print(data['name']);
              print("******");

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyFavsDEtailPage(
                              id: id,
                              idx: idx,
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
                                image:
                                    NetworkImage(data['images'].toString()))),
                        width: MediaQuery.of(context).size.width * 0.40,
                        height: MediaQuery.of(context).size.height * 0.12,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 40,
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: ListTile(
                          title: Text(data['price'].toString() + " \u20ba",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontFamily: "RobotoCondensed")),
                          subtitle: Text(data['name'],
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "RobotoCondensed")),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite,
                                color: mainColor.color,
                              )),
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            }).toList(),
          );
        }));
  }
}
