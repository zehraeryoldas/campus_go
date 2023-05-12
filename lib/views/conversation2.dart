import 'package:campusgo/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class conversation extends StatefulWidget {
  const conversation({super.key});

  @override
  State<conversation> createState() => _conversationState();
}

class _conversationState extends State<conversation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
         const Padding(
            padding: EdgeInsets.only(left: 10,top: 20),
            child: Text(
            "CampusGo",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: mainColor.color),
        ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(left: 10,),
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
                           const   PopupMenuItem(
                                child: Text("Sohbeti Sil",
                                    style:
                                        TextStyle(color: Colors.black, fontSize: 22)),
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
        ],
      ),
    );
  }
}