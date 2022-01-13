//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String postPhotoUrl;
  final String about;
  final String publisherId;
  final int likeNumber;
  final String locate;

  Post(
      {this.id,
      this.postPhotoUrl,
      this.about,
      this.publisherId,
      this.likeNumber,
      this.locate});

  //Taking and fetching the ones generated from Firestore as snapshots.
  factory Post.generateFromDoc(DocumentSnapshot doc) {
    return Post(
      id: doc.id,
      postPhotoUrl: doc.get("postPhotoUrl"),
      about: doc.get("about"),
      publisherId: doc.get("publisherId"),
      likeNumber: doc.get("likeNumber"),
      locate: doc.get("locate"),
    );
  }
}
