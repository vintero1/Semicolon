import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:semicolon_project/responsive/mobile_screen_layout.dart';
import 'package:semicolon_project/responsive/responsive_layout_screen.dart';
import 'package:semicolon_project/responsive/web_screen_layout.dart';
import 'package:semicolon_project/screens/login_screen.dart';
import 'package:semicolon_project/screens/signup_screen.dart';
import 'package:semicolon_project/utils/colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC6CcZp1OzymQs_p7CQu30-INBnQftbTCM",
          appId: "1:817857233059:web:445fea95bb0edf590ebf16",
          messagingSenderId: "817857233059",
          projectId: "test-80b49",
          storageBucket: 'test-80b49.appspot.com'),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Semicolon',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ), 
      // home: LoginScreen(),
      home: SignupScreen(),
    );
  }
}
