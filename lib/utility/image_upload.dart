import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

//image upload global bir şeydir. Çünkü image upload hep yapılacak bir iştir. ara bir katmandır. O yüzden utility diye bir katmanda belirtmek daha iyidir
// class ImageUploadManager {
//   final ImagePicker _picker = ImagePicker();

//   Future<XFile?> fetchFromLibrary() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     return image;
//   }
// }



