import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class conversationPage extends StatefulWidget {
  const conversationPage({super.key});

  @override
  State<conversationPage> createState() => _conversationPageState();
}

class _conversationPageState extends State<conversationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("Conversation"),
        
      ),
    );
  }
}
