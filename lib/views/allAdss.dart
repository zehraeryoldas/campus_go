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
  bool favMi = true;

  void favouritebutton() {
    setState(() {
      favMi = !favMi;
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   setState(() {
  //     var collection = FirebaseFirestore.instance
  //         .collection("productts")
  //         .where("numberOfLikes", isEqualTo: 1)
  //         .get();
  //     IconButton(
  //       onPressed: () {
  //         collection;
  //       },
  //       icon: Icon(
  //         Icons.favorite,
  //         color: Colors.red,
  //       ),
  //     );
  //   });
  // }

  // Future<void> favourite(
  //   String postUserId,
  //   String postId,
  // ) async {
  //   var begeni = await FirebaseFirestore.instance
  //       .collection("favourite")
  //       .where("status")
  //       .get();
  //   var currentUserID = FirebaseAuth.instance.currentUser!.uid;

  //   print("//////");
  //   print(currentUserID);
  //   print("//////");
  // }

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
                          child: favMi
                              ? IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("productss")
                                        .where('name', isEqualTo: data['name'])
                                        .get()
                                        .then((snapshot) {
                                      snapshot.docs.forEach((document) {
                                        document.reference
                                            .update({'numberOfLikes': 1});
                                      });
                                    });
                                    favouritebutton();
                                    favouriteService().addFavourite(
                                        postId,
                                        postUserId,
                                        1,
                                        FirebaseAuth.instance.currentUser!.uid,
                                      
                                        );
                                    // print("00000000");
                                    // print(data['id']);
                                    // print(data['user.name']);
                                    //  print("00000000");
                                    //favourite(postUserId, postId);
                                  },
                                  icon: Icon(Icons.favorite_border))
                              : IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("productss")
                                        .where('name', isEqualTo: data['name'])
                                        .get()
                                        .then((snapshot) {
                                      snapshot.docs.forEach((document) {
                                        document.reference
                                            .update({'numberOfLikes': 0});
                                      });
                                    });

                                    favouritebutton();
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: mainColor.color,
                                    
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

//   GridView Gridview(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//     return GridView.builder(
//         itemCount: snapshot.data!.docs.length,
//         gridDelegate:
//             new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (context, index) {
//           DocumentSnapshot data = snapshot.data!.docs[index];
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Stack(
//               children: <Widget>[
//                 Card(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),side: BorderSide(color: Colors.white)),
//                   child: Container(
//                     //child:  Image.network("https://cdn.pixabay.com/photo/2022/10/10/14/13/lotus-7511897_1280.jpg",fit: BoxFit.cover,),
//                     width: MediaQuery.of(context).size.height*0.20,
//                     height: MediaQuery.of(context).size.height*0.80,
//                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: mainColor.color,
//                      image: DecorationImage(image: NetworkImage(data['images'].toString()),fit: BoxFit.cover)
//                     ),
//                   ),
//                 ), //Container
//                 Positioned(
//                   top: MediaQuery.of(context).size.height*0.12,
//                   child: Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),side: BorderSide(color: Colors.white)),
//                     child: Container(
//                       width:  MediaQuery.of(context).size.height*0.20,
//                       height: MediaQuery.of(context).size.height*0.100,
//                       child: Column(children: [
//                         ListTile(
//                           subtitle: Text(data['name']),
//                           title: Text(data['price'].toString() + " TL"),
//                         ),
//                       ]),
//                     ),
//                   ),
//                 ) //Container)
//               ], //<Widget>[]
//             ),
//           );
//         },
//       );
//   }
}
