// ignore_for_file: unnecessary_string_interpolations

import 'package:campusgo/arayuz.dart';
import 'package:campusgo/models/products_model.dart';
import 'package:campusgo/services/products_services.dart';
import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/conversation.dart';
import 'package:campusgo/views/home.dart';
import 'package:campusgo/views/urunDetayMesajlasma.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AllAdsDetailPage extends StatefulWidget {
  final String? postUserId;
  final String? user;
  final String? resim;
  final String? name;
  final int? price;
  final String? durum;
  final String? aciklama;
  final String? konum;

  AllAdsDetailPage({
    super.key,
     this.postUserId,
     this.resim,
     this.name,
     this.price,
     this.durum,
     this.aciklama,
     this.konum,
     this.user,
  });

  @override
  State<AllAdsDetailPage> createState() => _AllAdsDetailPageState();
}

class _AllAdsDetailPageState extends State<AllAdsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name.toString(),
            style: const TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Arayuz()));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  color: Colors.black,
                ))
          ],
        ),
        body: ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage("${widget.resim}"),
              )),
            ),
            _myDivider(),
            ListTile(
              title: Text("${widget.price}" + " \u20ba",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
              subtitle:
                  Text("${widget.name}", style: const TextStyle(fontSize: 16)),
            ),
            _myDivider(),
            const Text("    Detaylar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(
              height: 10,
            ),
            Text(
              "     DURUM:                 ${widget.durum}",
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            _myDivider(),
            ListTile(
              title: const Text(" Açıklama",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text(
                "  ${widget.aciklama}",
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            _myDivider(),
            ListTile(
              title: const Text(" Konum",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text(
                "  ${widget.konum}",
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            _myDivider(),
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: mainColor.color,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ))),
              title: const Text("Profil Bilgileri",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text(
                "${widget.user}",
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            _myDivider(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        print("000000000");
                        print(widget.postUserId);
                        print("999999");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => urunDetayMesajlasma(
                                      postUserId: widget.postUserId.toString(),
                                      name: widget.name.toString(),
                                      price: widget.price!.toInt(),
                                      resim: widget.resim.toString(),
                                      konum: widget.konum.toString(),
                                      durum: widget.durum.toString(),
                                      user: widget.user.toString(),
                                      aciklama: widget.aciklama.toString(),
                                    ))));
                      },
                      icon: Icon(Icons.message),
                      label: Text("Sohbet"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(mainColor.color),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black)))),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.handshake_outlined),
                        label: Text("Yüzyüze Talep"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(mainColor.color),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.black))))),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Divider _myDivider() {
    return const Divider(
      height: 10,
      color: Colors.black,
    );
  }
}
