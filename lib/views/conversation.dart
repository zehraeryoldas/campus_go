import 'package:campusgo/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key,});
  

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  TextEditingController messageController = TextEditingController();
  // ignore: non_constant_identifier_names
  var mesajlarListesi = <String>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mesajlarListesi.add(messageController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CampusGo",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: mainColor.color),
        ),
      ),
      body: Card(
        child: ListView(
          children: [
            Container(
              width: 600,
              height: 600,
              // color: Colors.red,
              child: ListView(
                children: [
                  Text(
                    messageController.text,
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ],
              ),
            ),

            // Card(
            //   child: Row(
            //     children: [
            //       Text("Sohbetler",
            //           style: TextStyle(color: Colors.black, fontSize: 22)),
            //       Spacer(),
            //       Row(
            //         children: [
            //           IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            //           PopupMenuButton(
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(18)),
            //             elevation: 1,
            //             icon: Icon(Icons.more_vert),
            //             itemBuilder: ((context) => [
            //                   PopupMenuItem(
            //                     child: Text("Sohbeti Sil",
            //                         style: TextStyle(
            //                             color: Colors.black, fontSize: 22)),
            //                     value: 1,
            //                   )
            //                 ]),
            //             onSelected: ((value) {
            //               if (value == 1) {
            //                 print("Sohbet silindi");
            //               }
            //             }),
            //           )
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            TextField(
                controller: messageController,
                decoration: InputDecoration(
                  label: Text("Mesaj"),
                  suffixIcon: IconButton(
                    onPressed: () {
                      mesajlarListesi.add(messageController.text);
                      // messageController.clear();
                    },
                    icon: Icon(
                      Icons.send,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
