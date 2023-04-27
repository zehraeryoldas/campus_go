import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class category extends StatefulWidget {
  const category({super.key});

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {
  final Stream<QuerySnapshot> _categoryStream=FirebaseFirestore.instance.collection("category").snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream:_categoryStream ,
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
           if (snapshot.hasError) {
            return const Text('hatalı işlem');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
      return ListView(
        children: snapshot.data!.docs.map((DocumentSnapshot document){
           Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            String category_name=data['name'].toString();
               print("******");
            print(data['name']);
            print("******");
            return GestureDetector(
              onTap: (){},
              child: Card(
                child: ListTile(
                  title: Text(category_name),
                ),
              ),
            );
        })
      );

     },);
  }
}