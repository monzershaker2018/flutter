// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/component/custom_text.dart';
import 'package:flutter_ecommerce/component/custom_button.dart';
import 'package:flutter_ecommerce/component/custom_textformfield.dart';
import 'package:flutter_ecommerce/modelview/auth_view_model.dart';
import 'package:get/get.dart';

class SignupView extends GetWidget<AuthViewModel> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Sign Up",
                        size: 23,
                      ),
                      InkWell(
                          onTap: () {
                            Get.offAllNamed('login');
                          },
                          child: CustomText(
                            text: "Login",
                            color: Colors.green,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    onSaved: (value) {
                      controller.name = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please this field must be filled';
                      }
                      return null;
                    },
                    label: "Username",
                    hintText: "Monzer",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    onSaved: (value) {
                      controller.email = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please this field must be filled';
                      }
                      return null;
                    },
                    label: "Email",
                    hintText: "Monzer@gmail.com",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    onSaved: (value) {
                      controller.password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please this field must be filled';
                      }
                      return null;
                    },
                    label: "Password",
                    hintText: "****************",
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    color: Colors.green,
                    onPress: () {
                      try {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          controller.createAccountWithEmailAndPassword();
                        } else {
                          print("not valid");
                        }
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    text: "Sign Up",
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

// $ keytool -exportcert -keystore debug.keystore -list -v