import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/conversation.dart';
import 'package:campusgo/views/productSearch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../arayuz.dart';
import 'allAds.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final locationIdController = TextEditingController();

  TextEditingController userIdController = TextEditingController();

  CollectionReference location =
      FirebaseFirestore.instance.collection("location");
  String? dropdownValue1;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.red,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(30),
        //   ),
        // ),
        //leading: _location(),
        title: Text(
          "CampusGo",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: mainColor.color),
        ),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(30.0),
        //   child: Padding(
        //     padding: const EdgeInsets.only(right: 230),
        //     child: SizedBox(
        //       width: 200,
        //       child: _search(context),
        //     ),
        //   ),
        // ),

        bottom: PreferredSize(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: _search(context)),
            preferredSize: Size.fromHeight(30)),
        //leadingWidth: 120,
        // title: TextButton.icon(
        //     onPressed: () {
        //       showSearch(context: context, delegate: searchDelegate());
        //     },
        //     icon: const Icon(
        //       Icons.search,
        //       color: Colors.grey,
        //     ),
        //     label: const Text(
        //       "Kitap, defter vb.",
        //       style: TextStyle(
        //         color: Colors.grey,
        //       ),
        //     )),
        actions: [
          Row(
            children: [
              // PopupMenuButton(
              //     itemBuilder: (context) => [
              //           PopupMenuItem(
              //             child: Text("Güncelle"),
              //             value: 1,
              //           ),
              //           PopupMenuItem(
              //             child: Text("Sil"),
              //             value: 2,
              //           )
              //         ],
              //         onSelected: (value) {
              //           if(value==1){
              //             print("güncelle tıklandı");
              //           }
              //           if(value==2){
              //             print("Sil tıklandı");
              //           }
              //         },
              //         ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notification_add),
                color: mainColor.color,
              )
            ],
          )
        ],
      ),
      //body: conversationPage(),
      body: ilanlarim2(),

     
    );
  }

  TextButton _search(BuildContext context) {
    return TextButton.icon(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black26)))),
        onPressed: () {
          showSearch(context: context, delegate: searchDelegate());
        },
        icon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        label: const Text(
          "Kitap, defter vb.",
          style: TextStyle(
            color: Colors.grey,
          ),
        ));
  }

  StreamBuilder<QuerySnapshot<Object?>> _location() {
    return StreamBuilder<QuerySnapshot>(
        stream: location.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return Container(
            width: double.infinity,
            child: DropdownButton<String>(
              hint: Text("Konum Seç"),
              onChanged: (String? newValue) {
                setState(() {
                  //locationIdController.text = newValue!;
                  dropdownValue1 = newValue;
                });
              },
              value: dropdownValue1,
              items: snapshot.data!.docs.map((DocumentSnapshot doc) {
                return DropdownMenuItem(
                  alignment: Alignment.bottomCenter,
                  child: Text(doc['name']),
                  value: doc.reference.id.toString(),
                );
              }).toList(),
            ),
          );
        });
  }
}

/*class _categorys extends StatelessWidget {
  const _categorys({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder
    (
      stream: FirebaseFirestore.instance.collection('category').snapshots(),
      builder: ((context, snapshot) {
        
      if(snapshot.hasData){
        var data=snapshot.data;
        
        return SizedBox(
          height: 70,
          
          child: ListView.builder(scrollDirection:Axis.horizontal ,itemCount: snapshot.data!.docs.length,
          itemBuilder: ((context, index){
            DocumentSnapshot index2=snapshot.data!.docs[index];
            return  SizedBox(height: 50,child: Card(child: Text(index2['name']),)
            )
            
            ;
          })),
        );
      }
      else
      {return Center();}
    }));
  }
}*/
