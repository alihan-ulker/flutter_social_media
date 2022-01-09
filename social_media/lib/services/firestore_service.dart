import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/models/user.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DateTime time = DateTime.now();

//It saves the information of the user registered with create account to Cloud Firestore.
  Future<void> createClient({id, email, clientName, photoUrl = ""}) async {
    await _firestore.collection("clients").doc(id).set({
      "clientName": clientName,
      "email": email,
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
}
