import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:prototype3/models/user.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?>? get authStateChanges {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future currentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future currentUserUID() async {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
