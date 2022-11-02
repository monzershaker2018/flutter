// ignore_for_file: avoid_print, prefer_const_constructors, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/screens/login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //String? email, password;

 // final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
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
                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: emailController.text.trim().toLowerCase(),
                              password: passwordController.text.trim(),
                            );
                            print(
                                "your email is ${emailController.text} );                                                                    ");
                            print(
                                "your password is ${passwordController.text}");

                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              title: 'success',
                              desc: 'your account is created successfully ',
                            ).show();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Sorry!',
                                desc: 'The password provided is too weak.',
                              ).show();
                            } else if (e.code == 'email-already-in-use') {
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
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
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
