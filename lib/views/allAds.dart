import 'package:campusgo/utility/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ilanlarim2 extends StatefulWidget {
  @override
  State<ilanlarim2> createState() => _ilanlarimState();
}

class _ilanlarimState extends State<ilanlarim2> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return Gridview(snapshot);
      },
    );
  }

  GridView Gridview(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data!.docs.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          DocumentSnapshot data = snapshot.data!.docs[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),side: BorderSide(color: Colors.white)),
                  child: Container(
                    //child:  Image.network("https://cdn.pixabay.com/photo/2022/10/10/14/13/lotus-7511897_1280.jpg",fit: BoxFit.cover,),
                    width: MediaQuery.of(context).size.height*0.20,
                    height: MediaQuery.of(context).size.height*0.80,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: mainColor.color,
                     image: DecorationImage(image: NetworkImage(data['images'].toString()),fit: BoxFit.cover)
                    ),
                  ),
                ), //Container
                Positioned(
                  top: MediaQuery.of(context).size.height*0.12,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),side: BorderSide(color: Colors.white)),
                    child: Container(
                      width:  MediaQuery.of(context).size.height*0.20,
                      height: MediaQuery.of(context).size.height*0.100,
                      child: Column(children: [
                        ListTile(
                          subtitle: Text(data['name']),
                          title: Text(data['price'].toString() + " TL"),
                        ),
                      ]),
                    ),
                  ),
                ) //Container)
              ], //<Widget>[]
            ),
          );
        },
      );
  }
}
