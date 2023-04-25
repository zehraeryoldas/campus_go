import 'package:campusgo/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({
    super.key,
  });

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
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
      body: Column(
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
          SizedBox(
            width: double.infinity,
            height: 120,
            child: Card(
              
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.network("https://cdn.pixabay.com/photo/2023/04/18/08/42/children-7934514_1280.jpg"), //product photo will be displayed here
                    
                  ),
                  Expanded(
                    child: ListTile(
                      title:Text('name') ,
                      subtitle: Text('message'),
                      trailing: Column(
                        children: [
                          Text("3:25"),
                          PopupMenuButton(
                            child: Icon(Icons.more_vert),
                            itemBuilder: ((context) => [
                                  PopupMenuItem(
                                    child: Text("Sohbeti Sil"),
                                    value: 1,
                                  ),
                                  
                                ]),
                            onSelected: (menuItemValue) {
                              if (menuItemValue == 1) {
                                print("silindi");
                                
                              }
                             
                            },
                          ),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
