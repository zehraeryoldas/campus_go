import 'package:campusgo/utility/color.dart';
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
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("products")
      .snapshots();

  String? dropdownValue = 'Sil';

payPage newyork=payPage();
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

            // String id = data['rid']!;
            print("******");
            print(data['name']);
            print("******");

            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 10,
              child: Row(children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration( color: mainColor.color,
                      image: DecorationImage(image: NetworkImage(data['images'].toString()),fit: BoxFit.cover)
                    ),
                    width: 100,
                    height: 100,
                   
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: ListTile(
                      title: Text(
                        data['name'],
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            ),
                      ),
                      subtitle: Text(data['price'].toString() + " TL"),
                      trailing: DropdownButton(
                        borderRadius: BorderRadius.circular(35.0),
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("products")
                                .where('name', isEqualTo: data['name'])
                                .get()
                                .then((snapshot) {
                              snapshot.docs.forEach((document) {
                                document.reference.delete();
                              });
                            });
                            dropdownValue = newValue;
                          });
                        },
                        items: ['Sil'].map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      
                    ),
                  ),
                ),
              ]),
            );
          }).toList());
        });
  }
}