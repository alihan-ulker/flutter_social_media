import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

//Firebase's Storage service was used to upload posts and images.
class StorageService {
  Reference _storage = FirebaseStorage.instance.ref();
  late String photoId;

//The image requested to be loaded has been sent to the putFile method.
  Future<String> postImageUpload(File imageFile) async {
    photoId = Uuid().v4();
    UploadTask uploadManager =
        _storage.child("images/posts/post_$photoId.jpg").putFile(imageFile);
    TaskSnapshot snapshot = await uploadManager;
    String uploadedPhotoUrl = await snapshot.ref.getDownloadURL();
    return uploadedPhotoUrl;
  }
}
