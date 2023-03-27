import 'package:campusgo/utility/color.dart';
import 'package:campusgo/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    return await auth.signOut();
  }

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CampusGo",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: mainColor.color),
        ),
        bottom: PreferredSize(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
            ),
            preferredSize: const Size.fromHeight(30)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    (MaterialPageRoute(
                        builder: (context) => const UserLogin())));
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: mainColor.color,
              ))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

              // String id = data['rid']!;
              print("******");
              print(data['name']);
              print("******");

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/personAdd.jpg"))),
                        ),
                      ),
                      Column(
                        children: [
                          Card(
                            child: Container(
                              width: 250,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Center(
                                  child: Text(
                                data['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                            child: Container(
                              width: 250,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Center(
                                  child:
                                   Text(
                                data['email'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Card(
                    child: Container(
                      width: 380,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Center(
                          child: Text(
                        data['phone'].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            (MaterialPageRoute(
                                builder: (context) => const UserLogin())));
                      },
                      child: Text(
                        "Çıkış Yap",
                        style: TextStyle(
                            color: mainColor.color,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Text(
                        "Hesabı Sil",
                        style: TextStyle(
                            color: mainColor.color,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              );

              // return Column(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(top: 120),
              //       child: Card(
              //           child: ListTile(
              //         leading: IconButton(
              //             onPressed: () {},
              //             icon: Icon(
              //               Icons.person_add,
              //               size: 50,
              //               color: Colors.black,
              //             )),
              //         title: Padding(
              //           padding: const EdgeInsets.only(bottom: 10),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(data['name'],
              //                   style: TextStyle(
              //                       color: Colors.black87,
              //                       fontSize: 18.0,
              //                       fontFamily: "RobotoCondensed")),
              //               Text(data['email'].toString())
              //             ],
              //           ),
              //         ),
              //         //subtitle: Text(data['email'].toString()),
              //       )),
              //     ),
              //     SizedBox(height: 20,),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: InkWell(onTap: () {
              //   Navigator.pushReplacement(
              //       context,
              //       (MaterialPageRoute(
              //           builder: (context) => const UserLogin())));
              // },child: Text("Çıkış Yap",style: TextStyle(color: mainColor.color,fontWeight: FontWeight.bold),)),
              //     )
              //   ],
              // );

              // return SizedBox(
              //   width: 50,
              //   height: 120,
              //   child: Card(
              //       child: ListTile(
              //     leading: IconButton(
              //         onPressed: () {},
              //         icon: Icon(
              //           Icons.person_add,
              //           size: 80,
              //           color: Colors.black,
              //         )),
              //     title: Padding(
              //       padding: const EdgeInsets.only(bottom: 10),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text(data['name'],
              //               style: TextStyle(
              //                   color: Colors.black87,
              //                   fontSize: 18.0,
              //                   fontFamily: "RobotoCondensed")),
              //           Text(data['email'].toString())
              //         ],
              //       ),
              //     ),
              //     //subtitle: Text(data['email'].toString()),
              //   )),
              // );
            }).toList());
          }),
    );
  }
}
