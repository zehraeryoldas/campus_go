import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/allAdsDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ilanlarim2 extends StatefulWidget {
  @override
  State<ilanlarim2> createState() => _ilanlarimState();
}

class _ilanlarimState extends State<ilanlarim2> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('productss')
      .where("productStatus", isEqualTo: 1)
      .where('user.userStatus', isEqualTo: 1)
      .snapshots();
  bool favMi = true;
  var liste = [];
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
            String id = data['userId'].toString();
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
                              id: id,
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
                                    setState(() {
                                      favMi=!favMi;
                                     data['id'];
                                      //liste.add(favMi);
                                    });
                                  },
                                  icon: Icon(Icons.favorite_border))
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      favMi=!favMi;
                                    });
                                  },
                                  icon: Icon(Icons.favorite),
                                ),
                          // child: IconButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         favMi = !favMi;

                          //       });
                          //     },
                          //     icon: favMi
                          //         ? Icon(Icons.favorite_border)
                          //         : Icon(
                          //             Icons.favorite,
                          //             color: mainColor.color,
                          //           ))
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
                // child: Stack(
                //   children: <Widget>[

                //     // Card(
                //     //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),side: BorderSide(color: Colors.white)),
                //     //   child: Container(
                //     //     //child:  Image.network("https://cdn.pixabay.com/photo/2022/10/10/14/13/lotus-7511897_1280.jpg",fit: BoxFit.cover,),
                //     //     width: MediaQuery.of(context).size.height*0.20,
                //     //     height: MediaQuery.of(context).size.height*0.80,
                //     //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: mainColor.color,
                //     //      image: DecorationImage(image: NetworkImage(data['images'].toString()),fit: BoxFit.cover)
                //     //     ),
                //     //   ),
                //     // ), //Container
                //     // Positioned(
                //     //   top: MediaQuery.of(context).size.height*0.12,
                //     //   child: Card(
                //     //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),side: BorderSide(color: Colors.white)),
                //     //     child: Container(
                //     //       width:  MediaQuery.of(context).size.height*0.20,
                //     //       height: MediaQuery.of(context).size.height*0.100,
                //     //       child: Column(children: [
                //     //         ListTile(
                //     //           subtitle: Text(data['name']),
                //     //           title: Text(data['price'].toString() + " TL"),
                //     //         ),
                //     //       ]),
                //     //     ),
                //     //   ),
                //     // ) //Container)
                //   ], //<Widget>[]
                // ),
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
