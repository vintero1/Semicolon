import "dart:typed_data";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:semicolon_project/models/user.dart" as model;
import "package:semicolon_project/resources/storage_methods.dart";

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  // Sign Up a user
  Future<String> signUserUp({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Sign Up error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // Sign Up a user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);
        String profilePhotoUrl = await StorageMethods()
            .uploadImageToStorage('profilePictures', file, false);
        // Add a user to database

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          profilePhotoUrl: profilePhotoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        await _firestore.collection("users").doc(cred.user!.uid).set(
              user.toJson(),
            );

        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Bad format of the email!';
      } else if (err.code == 'weak-password') {
        res =
            'Password is not strong enough! It should be at least 6 characters.';
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // Sign In a user
  Future<String> signUserIn({
    required String email,
    required String password,
  }) async {
    String res = "Sign In error Occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Enter all fields!";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        res = 'This user is not found!';
      } else if (err.code == 'wrong-password') {
        res = 'Entered wrond password!';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
