// firebase_storage.FirebaseStorage storage =
//       firebase_storage.FirebaseStorage.instance;
//   File? _photo;
//   final ImagePicker _picker = ImagePicker();
//   Future imgFromGallery() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _photo = File(pickedFile.path);

//         //sonradan eklendi
//                 imagesController.text=_photo.toString();

//         uploadFile();
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future imgFromCamera() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);

//     setState(() {
//       if (pickedFile != null) {
//         _photo = File(pickedFile.path);

//         //        //sonradan eklendi
//         imagesController.text=_photo.toString();
//         uploadFile();
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future uploadFile() async {
//     if (_photo == null) return;
//     final fileName = basename(_photo!.path);
//     final destination = 'files/$fileName';

//     try {
//       final ref = firebase_storage.FirebaseStorage.instance
//           .ref(destination)
//           .child('file/');
//       await ref.putFile(_photo!);
//     } catch (e) {
//       print('error occured');
//     }
//   }

//   GestureDetector imageMethod(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _showPicker(context);
//       },
//       child: CircleAvatar(
//         radius: 55,
//         backgroundColor: mainColor.color,
//         child: _photo != null
//             ? ClipRRect(
//                 borderRadius: BorderRadius.circular(50),
//                 child: Image.file(
//                   _photo!,
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.fitHeight,
//                 ),
//               )
//             : Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(50)),
//                 width: 100,
//                 height: 100,
//                 child: Lottie.network(
//                     "https://assets7.lottiefiles.com/packages/lf20_urbk83vw.json")),
//       ),
//     );
//   }

//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Gallery'),
//                       onTap: () {
                        
//                         imgFromGallery();
//                         Navigator.of(context).pop();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text('Camera'),
//                     onTap: () {
//                       kameradanYukle();
//                       //imgFromCamera();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }