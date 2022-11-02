// ignore_for_file: avoid_print, prefer_const_constructors, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/component/alert.dart';
import 'package:ecommerce/screens/notes/home.dart';
import 'package:ecommerce/screens/auth/signup.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //String? email, password;

  // final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
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
                        'Login',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'This Email is required';
                        }
                        if (value.length < 7) {
                          return 'This Email is too short';
                        }
                        if (value.length > 50) {
                          return 'This Email is too long';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextFormField(
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
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          child: const Text('Login'),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                showLoading(context);
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailController.text
                                            .trim()
                                            .toLowerCase(),
                                        password:
                                            passwordController.text.trim());
                                User? user = FirebaseAuth.instance.currentUser;
                                print(user);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  Navigator.of(context).pop();
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Sorry!',
                                    desc: 'No user found for that email.',
                                  ).show();
                                } else if (e.code == 'wrong-password') {
                                  Navigator.of(context).pop();
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Sorry!',
                                    desc:
                                        'Wrong password provided for that user.',
                                  ).show();
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          })),
                  Row(
                    // ignore: sort_child_properties_last
                    children: <Widget>[
                      const Text('Do not have account?'),
                      TextButton(
                        child: const Text(
                          'Signup',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              )),
        ));
  }
}
