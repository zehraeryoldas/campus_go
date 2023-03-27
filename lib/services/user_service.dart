import 'package:campusgo/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<String?> addHedef2(
    String? email,
    String? name,
    int? phone,
    // String? password,
    // String? password2,
  ) async {
    usersModel userModel = usersModel(
      email: email,
      name: name,
      phone: phone,
      
      //password: password,
      //password2: password2,
    );

    try {
      DocumentReference sonuc1 = FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid);

      sonuc1.set(userModel.toJson());

      var id = sonuc1.id;
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'id': id});
    } on Exception catch (e) {
      // TODO
    }
  }
}
