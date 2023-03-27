import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class ProfilTasarimi extends StatefulWidget {
  const ProfilTasarimi({super.key});

  @override
  State<ProfilTasarimi> createState() => _ProfilTasarimiState();
}

class _ProfilTasarimiState extends State<ProfilTasarimi> {
  File? yuklenecekDosya;
  String? indirmeBaglantisi;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_)=>baglantiAl());
  // }
  void baglantiAl() async{
    String baglanti=await firebase_storage.FirebaseStorage.instance.ref().
    child('ilanlar').
    child(FirebaseAuth.instance.currentUser!.uid).
    child('ilan.png').getDownloadURL();

    setState(() {
      indirmeBaglantisi=baglanti;
    });
  }
  kameradanYukle() async{
    var alinandosya=await ImagePicker().pickImage(source: ImageSource.camera);

    //file tipinde tanımladığımız değişkene bu aldığımız dosyayı göndereceğiz
    setState(() {
      //yani dosyamız artık yuklenecekdosya değişkeninin içerisinde 
      yuklenecekDosya=File(alinandosya!.path);
    });
    //ve artık bunu sotrage ye yükleyelim
    final ref=firebase_storage.FirebaseStorage.instance.ref().
    child('ilanlar').
    child(FirebaseAuth.instance.currentUser!.uid).
    child('ilan.png');

    UploadTask yuklemegorevi=ref.putFile(yuklenecekDosya!);
    String url=await(await yuklemegorevi).ref.getDownloadURL();
    setState(() {
      indirmeBaglantisi=url;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container
    (
      child:Row (children:[
         indirmeBaglantisi==null? Text("resim yok") :Image.network( indirmeBaglantisi!,)
        ,ElevatedButton(onPressed: kameradanYukle,child: Text("yukle"),)]),
    );
  }
}