import 'package:campusgo/models/favourite_model.dart';
import 'package:campusgo/models/products_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class favservice {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<String?> addFavourite(
    String? post_id,
  ) async {
    favouriteModel fmodel = favouriteModel(
      post_id: post_id,
    );
    // Future<DocumentReference<Map<String, dynamic>>> sonuc = FirebaseFirestore
    //     .instance
    //     .collection("users")
    //     .doc(auth.currentUser!.uid)
    //     .collection("favorites")
    //     .add(fmodel.toJson());

    final citiesRef = firebaseFirestore.collection("users");

    

    // final ggbData = {"name": "Golden Gate Bridge", "type": "bridge"};
    citiesRef
        .doc(auth.currentUser!.uid)
        .collection("favorites")
        .add(fmodel.toJson());

    //  firebaseFirestore.collection('users').doc(auth.currentUser!.uid).collection('favorites').get().then((value) {
    //   value.docs.forEach((element) {
    //     var data = element.data() as Map<String,dynamic>;
    //     firebaseFirestore.collection('productss').doc(element['id']);
    //   });
    // });

    // firebaseFirestore.collection('users').get().then((value) {
    //   value.docs.forEach((element) {

    //    });
    // });

    // firebaseFirestore.collection('users').doc(auth.currentUser!.uid).get();
  }
}
