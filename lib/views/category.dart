
import 'package:campusgo/views/category_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class category extends StatefulWidget {
  const category({super.key});

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {
  var _categoryStream =
      FirebaseFirestore.instance.collection("category").snapshots();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _categoryStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loadingg...');
        return Column(
          children: [
           const Padding(
              padding: const EdgeInsets.only(right: 220),
              child: Text(
                "Kategorilere göz at..",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18),
              ),
            ),
            Expanded(
              child: Card(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    var category_id = data['id'].toString();
                    var category_name = data['name'].toString();

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => categoryDetails(
                              category_id: category_id,
                              category_name: category_name,
                            ),
                          ),
                        );
                        print("ggggg");
                        print(category_id);
                        print("ggggg");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0, color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: CircleAvatar(
                                  child: Image.network(data['icon'].toString()),
                                ),
                              ),
                              Text(
                                data['name'],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18.0,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: "RobotoCondensed"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
