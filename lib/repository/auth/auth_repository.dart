import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototype3/models/user_model.dart';

class AuthenticationRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  // User? get user => _firebaseAuth.currentUser;

  Future<void> signIn({required String email, required String password}) async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    try {
          await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password);
      // return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserCredential?> signUp(UserModel user) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Stream<UserModel> currentUser() {
    return _firebaseAuth.authStateChanges().map((User? user) {
      if (user != null) {
        return UserModel(uid: user.uid, email: user.email);
      } else {
        return UserModel(uid: "uid");
      }
    });
  }

  Future currentUserUID() async {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
