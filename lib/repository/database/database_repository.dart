import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototype3/models/user_model.dart';

class DatabaseRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // User? get user => _firebaseAuth.currentUser;
  addUserData(UserModel userData) async {
    await _db.collection("Users").doc(userData.uid).set(userData.toMap());
  }

  Future<List<UserModel>> retrieveUserData() async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Users").get();
    return snapshot.docs
        .map((docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<String> retrieveUserName(UserModel user) async{
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("items").doc(user.uid).get();
    return snapshot.data()!["displayName"];
  }
}
