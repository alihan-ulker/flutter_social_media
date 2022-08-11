//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Client {
  final String id;
  final String clientName;
  final String photoUrl;
  final String email;
  final String password;
  final String about;

  Client(
      {@required this.id,
      this.clientName,
      this.photoUrl,
      this.email,
      this.password,
      this.about});

//Generated from Firebase.
  factory Client.generateFromFirebase(User client) {
    return Client(
      id: client.uid,
      clientName: client.displayName,
      photoUrl: client.photoURL,
      email: client.email,
      about: '',
    );
  }

//Taking and fetching the ones generated from Firebase as snapshots.
  factory Client.generateFromDoc(DocumentSnapshot doc) {
    return Client(
      id: doc.id,
      clientName: doc.get("clientName"),
      email: doc.get("email"),
      password: doc.get("password"),
      photoUrl: doc.get("photoUrl"),
      about: doc.get("about"),
    );
  }
}
