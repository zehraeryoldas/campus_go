import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/allAdsDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../arayuz.dart';

class searchDelegate extends SearchDelegate {
  searchDelegate() : super(searchFieldLabel: "Kitap, defter vb.");

  @override
  ThemeData appBarTheme(BuildContext context) {
    // ignore: todo
    // TODO: implement appBarTheme
    return super.appBarTheme(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(
            Icons.clear,
            color: mainColor.color,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        //color: Colors.blue,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext) => const Arayuz()));
        },
        icon: const Icon(
          Icons.arrow_back,
          color: mainColor.color,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    //return Container();
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('products')
        .where('name', isEqualTo: query)
        .snapshots();

    // TODO: implement buildResults
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

            var id = data['userId'].toString();
            String resim = data['images'].toString();
            String name = data['name'].toString();

            int price = data['price'];
            String durum = data['status'];
            String aciklama = data['description'];
            String konum = data['location'];
            String user = data['user.name'].toString();

            // return Card(
            //   child: ListTile(
            //     title: Text(data['name']),
            //     subtitle: Text('fiyat:' + data['price'].toString()+" \u20ba"),
            //     trailing: Container(
            //       width: 80,
            //       height: 70,
            //       decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data['images'].toString()))),
            //     ),
            //   ),
            // );
            return Card(
              child: ListTile(
                leading: Container(
                    width: 80,
                    height: 70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(data['images'].toString())))),
                title: Text(data['name']),
                subtitle: Text('fiyat:' + data['price'].toString() + " \u20ba"),
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
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
        //child: telefonNoList(),s

        );
  }
}
