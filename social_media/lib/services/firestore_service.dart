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
}
