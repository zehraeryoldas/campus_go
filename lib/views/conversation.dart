import 'package:campusgo/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key, required this.userId});
  final String userId;

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  TextEditingController messageController = TextEditingController();
 
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
            
            Card(
              child: Row(
                children: [
                  Text("Sohbetler",
                      style: TextStyle(color: Colors.black, fontSize: 22)),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                      PopupMenuButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        elevation: 1,
                        icon: Icon(Icons.more_vert),
                        itemBuilder: ((context) => [
                              PopupMenuItem(
                                child: Text("Sohbeti Sil",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 22)),
                                value: 1,
                              )
                            ]),
                        onSelected: ((value) {
                          if (value == 1) {
                            print("Sohbet silindi");
                          }
                        }),
                      )
                    ],
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 530),
              child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                      label: Text("Mesaj"),
                      
                      suffixIcon: IconButton(onPressed: (){
                        
                      }, icon: Icon(Icons.send)))),
            ),
          ],
        ),
      ),
    );
  }
}
