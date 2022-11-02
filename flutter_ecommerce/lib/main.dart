// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/view/cart.dart';
import 'package:flutter_ecommerce/view/home.dart';
import 'package:flutter_ecommerce/view/login.dart';
import 'package:flutter_ecommerce/helper/binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_ecommerce/view/profile.dart';
import 'package:flutter_ecommerce/view/signup.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Biniding(),
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignupView()),
        GetPage(name: '/home', page: () => HomeView()),
        GetPage(name: '/cart', page: () => CartView()),
        GetPage(name: '/profile', page: () => ProfileView()),
       // GetPage(name: '/details', page: () => DetailsView()),
      ],
      home: const LoginScreen(),
    );
  }
}
