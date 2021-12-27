//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/models/user.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Client _userCreate(User client) {
    return client == null ? null : Client.generateFromFirebase(client);
  }

  Stream<Client> get statusTracker {
    return _firebaseAuth.authStateChanges().map(_userCreate);
  }
}
