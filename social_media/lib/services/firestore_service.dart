import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/models/user.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DateTime time = DateTime.now();

//It saves the information of the user registered with create account to Cloud Firestore.
  Future<void> createClient(
      {id, email, password, clientName, photoUrl = ""}) async {
    await _firestore.collection("clients").doc(id).set({
      "clientName": clientName,
      "email": email,
      "password": password,
      "photoUrl": photoUrl,
      "about": "",
      "createdTime": time,
    });
  }

//To fetch the information of the user who created the account.
  Future<Client?> getClient(id) async {
    DocumentSnapshot doc = await _firestore.collection("clients").doc(id).get();
    if (doc.exists) {
      Client client = Client.generateFromDoc(doc);
      return client;
    }
    return null;
  }

//Retrieves follower counts from Firestore.
  Future<int> numberOfFollower(clientId) async {
    QuerySnapshot snapshot = await _firestore
        .collection("follower")
        .doc(clientId)
        .collection("clientFollower")
        .get();
    return snapshot.docs.length;
  }

////Retrieves follow-up counts from Firestore.
  Future<int> numberOfFollowUp(clientId) async {
    QuerySnapshot snapshot = await _firestore
        .collection("followUp")
        .doc(clientId)
        .collection("clientFollowUp")
        .get();
    return snapshot.docs.length;
  }

//To create posts in Firestore.
  Future<void> createPost({postPhotoUrl, about, publisherId, locate}) async {
    await _firestore
        .collection("posts")
        .doc(publisherId)
        .collection("clientPosts")
        .add({
      "postPhotoUrl": postPhotoUrl,
      "about": about.text,
      "publisherId": publisherId,
      "likeCount": 0,
      "locate": locate.text,
      "createdTime": time,
    });
  }

//To fetch posts shared from Firestore by last post date.
  Future<List<Post>> getPosts(clientId) async {
    QuerySnapshot snapshot = await _firestore
        .collection("posts")
        .doc(clientId)
        .collection("clientPosts")
        .orderBy("createdTime", descending: true)
        .get();

    //To return posts as a list.
    List<Post> posts =
        snapshot.docs.map((doc) => Post.generateFromDoc(doc)).toList();
    return posts;
  }
}
