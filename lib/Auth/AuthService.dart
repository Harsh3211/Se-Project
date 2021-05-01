import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  //Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(_firebaseAuth.currentUser.displayName);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password, String userName}) async {
    print("Inside SignUp Pages");
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = _firebaseAuth.currentUser;
      print(user);
      user.updateProfile(displayName: userName);
      print(user.displayName);
      print(user.uid);

      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


}
