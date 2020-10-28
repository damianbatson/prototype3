import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  
  Stream<String> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map((User user) => user?.uid);
  }

  
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user.uid;
    
  }

 
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    return (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user.uid;
    // return authResult.user.uid;
  }

  
  Future currentUser() async {
    return _firebaseAuth.currentUser;
  }

    Future<String> currentUserUID() async {
    return (_firebaseAuth.currentUser).uid;
  }

  
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
