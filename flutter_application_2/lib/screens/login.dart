// ignore_for_file: avoid_print, prefer_const_constructors, use_build_context_synchronously, await_only_futures

import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/screens/home.dart';
import 'package:flutter_application_2/screens/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  route() async {
    User? user = await FirebaseAuth.instance.currentUser;
    print(user);
    if (user != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    route();
  }

  // ignore: prefer_typing_uninitialized_variables
  var email, password;
  TextEditingController emailContorller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'TutorialKart',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'This Email Field is required';
                      }

                      if (value.length < 5) {
                        return 'This Email is too short';
                      }
                      if (value.length > 50) {
                        return 'This Email is too long';
                      }
                      return null;
                    },
                    controller: emailContorller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    onSaved: (val) {
                      password = val;
                    },
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'This Password Field is required';
                      }
                      if (value.length < 4) {
                        return 'This Password Field is too short';
                      }
                      if (value.length > 20) {
                        return 'This Password Field is too long';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text(
                    'Forgot Password',
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailContorller.text
                                        .trim()
                                        .toLowerCase(),
                                    password: passwordController.text.trim());
                            User? user = FirebaseAuth.instance.currentUser;
                            print(user);

                            // if (user != null && !user.emailVerified) {
                            //   await user.sendEmailVerification();
                            //   AwesomeDialog(
                            //     context: context,
                            //     dialogType: DialogType.error,
                            //     animType: AnimType.rightSlide,
                            //     title: 'Sorry!',
                            //     desc: 'please verfiy your email and try again.',
                            //   ).show();
                            // } else {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                            // }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Sorry!',
                                desc: 'No user found for that email.',
                              ).show();
                            } else if (e.code == 'wrong-password') {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Sorry!',
                                desc: 'Wrong password provided for that user.',
                              ).show();
                            }
                          }
                        }
                      },
                    )),
                Row(
                  // ignore: sort_child_properties_last
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )),
      ),
    );
  }
}
