import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:semicolon_project/screens/add_post_screen.dart';
import 'package:semicolon_project/screens/feed_screen.dart';
import 'package:semicolon_project/screens/profile_screen.dart';
import 'package:semicolon_project/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('Notifications', textAlign: TextAlign.center,style: TextStyle(fontSize: 18)),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
