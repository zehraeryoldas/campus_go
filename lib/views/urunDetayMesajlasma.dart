import 'package:campusgo/utility/color.dart';
import 'package:campusgo/views/allAdsDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class urunDetayMesajlasma extends StatefulWidget {
  urunDetayMesajlasma({
    super.key,
    this.postUserId,
    this.user,
    this.resim,
    this.name,
    this.price,
    this.durum,
    this.aciklama,
    this.konum,
  });
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllAdsDetailPage(
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
    body: ListView(
      children: [
        
      ],
    ),
    
    );
  }
}
