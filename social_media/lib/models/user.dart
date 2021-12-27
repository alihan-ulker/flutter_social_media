import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User {
  final String id;
  final String userName;
  final String photoUrl;
  final String email;
  final String about;

  User(
      {required this.id,
      required this.userName,
      required this.photoUrl,
      required this.email,
      required this.about});

  factory User.generateFromFirebase(User user) {
    return User(
      id: user.id,
      userName: user.userName,
      photoUrl: user.photoUrl,
      email: user.email,
      about: '',
    );
  }

  factory User.generateFromDoc(DocumentSnapshot doc) {
    var docData = doc.data();
    return User(
      id: doc.id,
      userName: doc.get("userName"),
      email: doc.get('email'),
      photoUrl: doc.get('photoUrl'),
      about: doc.get('about'),
    );
  }
}
