//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media/models/user.dart';

//Authorization service

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String activeClientId;

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

  Future<Client> loginWithGoogle() async {
    GoogleSignInAccount googleAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleAuthorizationCard =
        await googleAccount.authentication;

    AuthCredential passwordFreeLogin = GoogleAuthProvider.credential(
        idToken: googleAuthorizationCard.idToken,
        accessToken: googleAuthorizationCard.accessToken);

    UserCredential loginCard =
        await _firebaseAuth.signInWithCredential(passwordFreeLogin);

    return _userCreate(loginCard.user);
  }
}
