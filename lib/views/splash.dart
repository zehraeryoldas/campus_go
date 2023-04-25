import 'package:campusgo/arayuz.dart';
import 'package:campusgo/assets.dart';
import 'package:campusgo/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grock/grock_exports.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      Grock.toRemove(Arayuz());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      backgroundColor: Colors.white10,
      body: Center(
        child: Image.asset(Assets.images.personAddJPG),
      ),
    );
  }
}