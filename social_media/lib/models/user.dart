//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Client {
  final String id;
  final String clientName;
  final String photoUrl;
  final String email;
  final String about;

  Client(
      {@required this.id,
      this.clientName,
      this.photoUrl,
      this.email,
      this.about});

  factory Client.generateFromFirebase(User client) {
    return Client(
      id: client.uid,
      clientName: client.displayName,
      photoUrl: client.photoURL,
      email: client.email,
      about: '',
    );
  }

  factory Client.generateFromDoc(DocumentSnapshot doc) {
    return Client(
      id: doc.id,
      clientName: doc.get("clientName"),
      email: doc.get("email"),
      photoUrl: doc.get("photoUrl"),
      about: doc.get("about"),
    );
  }
}
