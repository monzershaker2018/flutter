// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_constructors_in_immutables, unnecessary_new, avoid_print

import 'package:crud/component/functions.dart';
import 'package:crud/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginState = GlobalKey<FormState>();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Login'),
          leading: InkWell(
            onTap: () {
              SystemNavigator.pop();
            },
            child: Icon(
              Icons.close,
              size: 30,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _loginState,
          child: ListView(
            children: [
             
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: filed(true),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: filed(false),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green, padding: EdgeInsets.all(20)),
                    onPressed: () {
                      if (_loginState.currentState!.validate()) {
                        print("Validated");
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new MainScreen()));
                      } else {
                        print("Not Validated");
                      }
                    },
                    child: Text("Login")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField filed(bool email) {
    if (email == true) {
      return TextFormField(
          controller: emailCon,
          validator: validEmail,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text("Email")));
    } else {
      return TextFormField(
          obscureText: true,
          controller: passwordCon,
          validator: validPassword,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text("Password")));
    }
  }
}
