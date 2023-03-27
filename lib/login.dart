import 'package:campusgo/arayuz.dart';
import 'package:campusgo/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController namecontroller = TextEditingController();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController sifreController = TextEditingController();
  TextEditingController sifretekrarController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  String name = "kullanıcı adı";
  String email = "email";
  String sifre = "şifre";
  String sifreTekrar = "şifre doğrula";

  String kayitOl1 = "Kayıt Ol";
  String girisYap1 = "Giriş Yap";
  void showMessage(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Şifreler Uyuşmuyor'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Future<void> kayitOl() async {

    if(sifreController.text==sifretekrarController.text){
      await auth
        .createUserWithEmailAndPassword(
            email: emailcontroller.text, password: sifreController.text)
        .then((kullanici) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid)
          .set({"email": emailcontroller.text, "name": namecontroller.text}); });
    }
    else
    {
    showMessage(context);
    }

  }

  signOut() async {
    return await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    String topImage = "assets/images/topImage.png";
    return Scaffold(
        backgroundColor: Color(0xff21254A),
        body: SafeArea(
          child: ListView(
            children: [
              topImageContainer(height, topImage),
              Column(
                children: [
                  Text(
                    "WELCOME, \nBACK!",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  _myContainers(
                      name,
                      namecontroller,
                      TextInputType.none,
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      )),
                  _myContainers(
                      email,
                      emailcontroller,
                      TextInputType.emailAddress,
                      Icon(
                        Icons.email,
                        color: Colors.white,
                      )),
                  _myContainers(
                      sifre,
                      sifreController,
                      TextInputType.none,
                      Icon(
                        Icons.password,
                        color: Colors.white,
                      )),
                  _myContainers(
                      sifreTekrar,
                      sifretekrarController,
                      TextInputType.none,
                      Icon(
                        Icons.password,
                        color: Colors.white,
                      )),
                  _elevatedButton(kayitOl1, Icon(Icons.start), kayitOl),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserLogin()));
                      },
                      child: Text("Giris Sayfasina Dön",
                          style: TextStyle(color: Colors.pink.shade200)))
                ],
              ),
            ],
          ),
        ));
  }

  Container topImageContainer(double height, String topImage) {
    return Container(
      height: height * .25,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(topImage),
        ),
      ),
    );
  }

  Padding _elevatedButton(String text, Icon icon, Future<void> fonksiyon()) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff31274F))),
          icon: icon,
          onPressed: fonksiyon,
          label: Text(text)),
    );
  }

  Container _myContainers(String metin, TextEditingController controller,
      TextInputType type, Icon icon) {
    return Container(
      //decoration: BoxDecoration(color: Colors.transparent),
      width: 273,
      height: 50,
      child: TextField(
        style: TextStyle(color: Colors.white),
        keyboardType: type,
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: icon,
          label: Text(
            metin,
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}
