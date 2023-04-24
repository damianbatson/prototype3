import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototype3/bloc/bloc/auth_bloc.dart';
import 'package:prototype3/models/user_model.dart';
import 'package:prototype3/repository/auth/auth_service.dart';
import 'package:prototype3/utils/showSnackbar.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  AuthService authService = AuthService();

  // User? get user => _firebaseAuth.currentUser;

  @override
  Future<UserCredential?> signIn(UserModel user) async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    try {
      return authService.signInWithEmailAndPassword(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<UserCredential?> signUp(UserModel user) async {
    try {
      return authService.createUserWithEmailAndPassword(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Stream<UserModel> getCurrentUser() {
    return authService.currentUser();
  }

  Future currentUserUID() async {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<void> signOut() async {
    return authService.signOut();
  }

  @override
  Future<String?> retrieveUserName(UserModel user) {
    return dbService.retrieveUserName(user);
  }
}

abstract class AuthenticationRepository {
  Stream<UserModel> getCurrentUser();
  Future<UserCredential?> signUp(UserModel user);
  Future<UserCredential?> signIn(UserModel user);
  Future<void> signOut();
  Future<String?> retrieveUserName(UserModel user);
}
