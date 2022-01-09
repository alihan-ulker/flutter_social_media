import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

//Firebase's Storage service was used to upload posts and images.
class StorageService {
  Reference _storage = FirebaseStorage.instance.ref();

//The image requested to be loaded has been sent to the putFile method.
  Future<String> postImageUpload(File imageFile) async {
    UploadTask uploadManager =
        _storage.child("images/posts/post.jpg").putFile(imageFile);
    TaskSnapshot snapshot = await uploadManager;
    String uploadedPhotoUrl = await snapshot.ref.getDownloadURL();
    return uploadedPhotoUrl;
  }
}
