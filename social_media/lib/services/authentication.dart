//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/models/user.dart';

//Authorization service

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Client _userCreate(User client) {
    return client == null ? null : Client.generateFromFirebase(client);
  }

  Stream<Client> get statusTracker {
    return _firebaseAuth.authStateChanges().map(_userCreate);
  }

  Future<Client> registerWithEmail(String mail, String password) async {
    var loginCard = await _firebaseAuth.createUserWithEmailAndPassword(
        email: mail, password: password);
    return _userCreate(loginCard.user);
  }

  Future<Client> loginWithEmail(String mail, String password) async {
    var loginCard = await _firebaseAuth.signInWithEmailAndPassword(
        email: mail, password: password);
    return _userCreate(loginCard.user);
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
