import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/favourite_modell.dart';

class favouriteService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<String?> addFavourite(
    String? post_id,
    String? post_user_id,
    int? status,
    String? user_id,
  ) async {
    favouriteModel fmodel = favouriteModel(
        post_id: post_id,
        post_user_id: post_user_id,
        status: status,
        user_id: user_id);

    String sonuc = "";

    DocumentReference sonuc2 = FirebaseFirestore.instance
        .collection("favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    var userId = sonuc2.id;

    DocumentReference sonuc3 = await FirebaseFirestore.instance
        .collection("favorite")
        .add(fmodel.toJson());

    // var idx = sonuc1.id;
    var ids = sonuc3.id;

    

  }
}
