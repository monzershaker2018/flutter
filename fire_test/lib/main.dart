// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserCredential? userCredential;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: Text("sign up"),
          onPressed: () async {
            try {
              userCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: "monzershaker2018@gmail.com",
                      password: "Monzer2020@");
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  title: 'Sorry!',
                  desc: 'The password provided is too weak.',
                  btnOkOnPress: () {
                    Navigator.pop(context);
                  },
                ).show();
              } else if (e.code == 'email-already-in-use') {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  title: 'Sorry!',
                  desc: 'The account already exists for that email.',
                  btnOkOnPress: () {
                    
                  },
                ).show();
              }
            } catch (e) {
              print(e);
            }
            print(userCredential!.user!.email);
          },
        ),
        ElevatedButton(
            onPressed: () async {
              User? user = FirebaseAuth.instance.currentUser;
              print(user!.emailVerified);
              if (user.emailVerified == false) {
                await user.sendEmailVerification();
                print("please verfiy email");
                print("  email link sent");
              } else {
                try {
                  userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: "monzershaker2018@gmail.com",
                          password: "Monzer2020@");
                  print("login succffuly");
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              }
            },
            child: Text("sign in")),
        ElevatedButton(onPressed: () {}, child: Text("Add user"))
      ],
    );
  }
}
