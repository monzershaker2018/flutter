// ignore_for_file: avoid_print, prefer_const_constructors, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/component/alert.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce/screens/auth/login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //String? email, password;

  // final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
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
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'This Name is required';
                        }
                        if (value.length < 4) {
                          return 'This Name is too short';
                        }
                        if (value.length > 20) {
                          return 'This Name is too long';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),
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
                        child: const Text('Sign Up'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              showLoading(context);
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email:
                                    emailController.text.trim().toLowerCase(),
                                password: passwordController.text.trim(),
                              );
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .add({
                                'username': nameController.text,
                                'email': emailController.text,
                              });
                              print(
                                  "your email is ${emailController.text} );                                                                    ");

                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'success',
                                desc: 'your account is created successfully ',
                              ).show();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                Navigator.of(context).pop();
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Sorry!',
                                  desc: 'The password provided is too weak.',
                                ).show();
                              } else if (e.code == 'email-already-in-use') {
                                Navigator.of(context).pop();

                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Sorry!',
                                  desc:
                                      'The account already exists for that email.',
                                ).show();
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                      )),
                  Row(
                    // ignore: sort_child_properties_last
                    children: <Widget>[
                      const Text('Already have account?'),
                      TextButton(
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => Login()));
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
