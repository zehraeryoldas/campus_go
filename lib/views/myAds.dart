import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/myAdsDetail.dart';
import 'package:campusgo/views/myAdsUpdate.dart';
import 'package:campusgo/views/productAdd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ilanlarim extends StatefulWidget {
  @override
  State<ilanlarim> createState() => _ilanlarimState();
}

class _ilanlarimState extends State<ilanlarim> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection("productss")
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('productStatus', isEqualTo: 1)
      .where('user.userStatus', isEqualTo: 1)
      .snapshots();
//  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
//       .collection("users")
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .collection("products")
//       .snapshots();

  String? dropdownValue = 'Sil';

  payPage newyork = payPage();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

            print("******");
            print(data['name']);
            print("******");

            return GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyAdsDetail(
                              id: id,
                              resim: resim,
                              name: name,
                              price: price,
                              durum: durum,
                              aciklama: aciklama,
                              konum: konum,
                              idx: idx,
                              kategori: kategori,
                            )));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                // elevation: 10,
                child: Row(children: [
                  Card(
                    child: Container(
                      //color: Colors.red,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(data['images'].toString()))),
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 40,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: ListTile(
                        title: Text(data['name'],
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                                fontFamily: "RobotoCondensed")),
                        subtitle: Text(data['price'].toString() + " \u20ba"),
                        trailing: PopupMenuButton(
                          child: Icon(Icons.more_vert),
                          itemBuilder: ((context) => [
                                PopupMenuItem(
                                  child: Text("İlanı kaldır"),
                                  value: 1,
                                ),
                                PopupMenuItem(
                                  child: Text("İlanı Güncelle"),
                                  value: 2,
                                ),
                              ]),
                          onSelected: (menuItemValue) {
                            if (menuItemValue == 1) {
                              print("silindi");
                              setState(() {
                          

                                FirebaseFirestore.instance
                                    .collection("productss")
                                    .where('name', isEqualTo: data['name'])
                                    .get()
                                    .then((snapshot) {
                                  snapshot.docs.forEach((document) {
                                    document.reference
                                        .update({'productStatus': 0});
                                  });
                                });
                              });
                            }
                            if (menuItemValue == 2) {
                              print("güncellendi");
                              setState(() {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyAdsUpdate(
                                              id: idx,
                                              name: name,
                                              aciklama: aciklama,
                                              durum: durum,
                                              idx: idx,
                                              konum: konum,
                                              kategori: kategori,
                                              price: price,
                                              resim: resim,
                                            )));
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            );
          }).toList());
        });
  }
}
