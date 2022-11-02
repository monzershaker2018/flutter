// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:ecommerce/screens/notes/home.dart';
import 'package:ecommerce/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
// ...
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isLogin;

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      isLogin = true;
    } else {
      isLogin = false;
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: isLogin ? Home() : Login());
  }
}
