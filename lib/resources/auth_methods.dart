import "dart:typed_data";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:semicolon_project/resources/storage_methods.dart";

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up a user
  Future<String> signUserUp({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
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
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'profilePhotoUrl': profilePhotoUrl,
        });

        res = "success";
      }
    } on FirebaseAuthException catch(err){
      if(err.code == 'invalid-email'){
        res = 'Bad format of the email!';
      }else if(err.code == 'weak-password'){
        res = 'Password is not strong enough! It should be at least 6 characters.'; 
      }
    }
    catch (err) {
      return err.toString();
    }
    return res;
  }
}
