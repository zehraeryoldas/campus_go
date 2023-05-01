// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/allAdsDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'firebaseChat.dart';

class urunDetayMesajlasma extends StatefulWidget {
  urunDetayMesajlasma({
    super.key,
    this.postId,
    this.postUserId,
    this.user,
    this.resim,
    this.name,
    this.price,
    this.durum,
    this.aciklama,
    this.konum,
  });
  final String? postId;
  final String? postUserId;
  final String? user;
  final String? resim;
  final String? name;
  final int? price;
  final String? durum;
  final String? aciklama;
  final String? konum;

  @override
  State<urunDetayMesajlasma> createState() => _urunDetayMesajlasmaState();
}

class _urunDetayMesajlasmaState extends State<urunDetayMesajlasma> {
  TextEditingController messageController = TextEditingController();

  void messageAdded(String text) {
    FirebaseFirestore.instance
        .collection("productss")
        .doc(widget.postId)
        .collection("chats")
        .add({
      'message': text,
      'timeStamp': DateTime.now(),
      'senderId': FirebaseAuth.instance.currentUser!.uid,
      'user_name': widget.user,
      'receiverId': widget.postUserId
    });
    messageController.text = "";
    bildirimGoster();
  }

  void messageRemoved(String text) {
    FirebaseFirestore.instance
        .collection("productss")
        .doc(widget.postId)
        .collection("chats")
        .get()
        .then((value) {
      value.docs.forEach((document) {
        document.reference.delete();
      });
    });
  }

  var flp = FlutterLocalNotificationsPlugin();

  Future<void> androidKurulum() async {
    var androidAyari =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosAyari = const DarwinInitializationSettings();
    //ayarlar oluşturulduktan sonra birleştiriyorum
    var kurulumAyari =
        InitializationSettings(android: androidAyari, iOS: iosAyari);
    await flp.initialize(kurulumAyari,
        onDidReceiveNotificationResponse: bildirimSecilme);
    //bu şekilde hem android hem ios için ayarlar verildi,
    //birleştirildi kurulum gerçekleştrildi.
  }

  Future<void> bildirimSecilme(
      NotificationResponse notificationResponse) async {
    var payLoad = notificationResponse.payload;
    if (payLoad != null) {
      print("Bildirim seçildi,$payLoad");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //uygulama ilk açıldığında
    //kurulum fonksiyonunu gerçekleştiriyoruz.
    // Bununla işlerimizi halledebiliyoruz.
    androidKurulum();
  }

  Future<void> bildirimGoster() async {
    var androidBildirimDetay = const AndroidNotificationDetails(
        "kanal id", "kanal başlık",
        channelDescription: "kanal açıklama",
        priority: Priority.high,
        importance: Importance.max);
    var iosBildirimDetay =
        const DarwinNotificationDetails(); //detaylandırma gerek yok ios bunu kendi hallediyor.
    //bu iki yapıyı birleştirelim
    var bildirimDetay = NotificationDetails(
        android: androidBildirimDetay, iOS: iosBildirimDetay);
    //mesajın gösterilmesi için başlık,içerik, detay bilgilerini verdik.
    await flp.show(0, widget.user, "fiyat nedir", bildirimDetay,
        payload: "payload içerik");
  }

  Future<void> gecikmeliBildirimGoster() async {
    var androidBildirimDetay = const AndroidNotificationDetails(
        "kanal id", "kanal başlık",
        channelDescription: "kanal açıklama",
        priority: Priority.high,
        importance: Importance.max);
    var iosBildirimDetay =
        const DarwinNotificationDetails(); //detaylandırma gerek yok ios bunu kendi hallediyor.
    //bu iki yapıyı birleştirelim
    var bildirimDetay = NotificationDetails(
        android: androidBildirimDetay, iOS: iosBildirimDetay);
    //mesajın gösterilmesi için başlık,içerik, detay bilgilerini verdik.
    tz.initializeTimeZones();
    var gecikme = tz.TZDateTime.now(tz.local).add(const Duration(
        seconds:
            10)); //.add sayesinde gecikme ekliyoruz.mevcut zamanda gecikme yaptık.
    await flp.zonedSchedule(
        0, "fatmanur", "fiyat ne kadar", gecikme, bildirimDetay,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle:
            true //telefon ekranı kapalıyken bildirim geldiğinde ekranın uyanmasını sağlıyor.
        ,
        payload:
            "Payload içerik gecikmeli" //bildirime tıklandığında bilgi eklenir.

        );
  }

  @override
  Widget build(BuildContext context) {
    //final String userId = "pceXDyA3HagfmzQ8vyXw8vokOaz1";
    final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
        .collection("productss")
        .doc(widget.postId)
        .collection('chats')
        .where("senderId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllAdsDetailPage(
                            postId: widget.postId,
                            resim: widget.resim,
                            name: widget.name,
                            price: widget.price,
                            durum: widget.durum,
                            aciklama: widget.aciklama,
                            konum: widget.konum,
                            user: widget.user,
                          )));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Row(
          children: [
            SizedBox(
                width: 50,
                height: 50,
                child: Image.network(widget.resim.toString())),
            Expanded(
                child: ListTile(
              title: Text(
                widget.user.toString(),
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                widget.name.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ))
          ],
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.call,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ))
            ],
          )
        ],
      ),
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: ListView.builder(
      //           itemCount: 10,
      //           itemBuilder: ((context, index) {
      //             return ListTile(
      //               title: Align(
      //                   alignment: index % 2 == 0
      //                       ? Alignment.centerLeft
      //                       : Alignment.centerRight,
      //                   child: Container(
      //                     padding: EdgeInsets.all(8),
      //                     decoration: BoxDecoration(
      //                         color: Colors.yellow,
      //                         borderRadius: BorderRadius.horizontal(
      //                             left: Radius.circular(10),
      //                             right: Radius.circular(10))),
      //                     child: Text("Deneme mesajı"),
      //                   )),
      //             );
      //           })),
      //     ),
      //     Row(
      //       children: [
      //         Expanded(
      //             child: Container(
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.horizontal(
      //                         left: Radius.circular(25),
      //                         right: Radius.circular(25))),
      //                 child: Row(
      //                   children: [
      //                     Expanded(
      //                       child: TextField(
      //                         decoration: InputDecoration(hintText: "Mesaj"),
      //                       ),
      //                     ),
      //                    IconButton(onPressed: (){}, icon: Icon(Icons.send))
      //                   ],
      //                 )))
      //       ],
      //     )
      //   ],
      // ),

      body: StreamBuilder(
          stream: messageStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error : ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            }
            return Column(children: [
              Expanded(
                child: ListView(
                  children: snapshot.data!.docs
                      .map((doc) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(doc['message']),
                                  trailing: PopupMenuButton(
                                    itemBuilder: ((context) => [
                                          PopupMenuItem(
                                            child: Text("Mesajı sil"),
                                            value: 1,
                                          ),
                                        ]),
                                    onSelected: ((value) {
                                      if (value == 1) {
                                        messageRemoved(messageController.text);
                                      }
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Divider(
                thickness: 3,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(25),
                                  right: Radius.circular(25))),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onSubmitted: messageAdded,
                                  decoration:
                                      InputDecoration(hintText: "Mesaj"),
                                  controller: messageController,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    messageAdded(messageController.text);
                                    bildirimGoster();
                                  },
                                  icon: Icon(Icons.send))
                            ],
                          )))
                ],
              )
            ]);
          }),
    );
  }
}
