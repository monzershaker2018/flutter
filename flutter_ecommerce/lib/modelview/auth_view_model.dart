// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, prefer_final_fields, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecommerce/services/user_service.dart';
import 'package:flutter_ecommerce/model/user_model.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_ecommerce/view/home.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  // FacebookLogin _facebookLogin = FacebookLogin();
  FirebaseAuth _auth = FirebaseAuth.instance;
  var name, password, email;

  void googleGignInMethod() async {
    try {
      GoogleSignInAccount? googleuser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleuser!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      print(userCredential.user);
    } catch (e) {
      print(e.toString());
    }
  }

  // void faceboookSignMethod() async {
  //   FacebookLoginResult result = await _facebookLogin.logIn(['email']);

  //   var accessToken = result.accessToken.token;
  //   if (result.status == FacebookLoginStatus) {
  //     var faceCred = FacebookAuthProvider.credential(accessToken);
  //     UserCredential credential = await _auth.signInWithCredential(faceCred);
  //     print(credential);
  //   }
  // }

  void signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(const HomeView());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("user-not-found", 'No user found for that email.',
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('wrong-password', 'Wrong password provided for that user.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void createAccountWithEmailAndPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        await UserService().addUser(UserModel(
          uid: user.user!.uid,
          name: name,
          email: user.user!.email,
          pic: '',
        ));
        Get.offAllNamed('home');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("weak-password", 'The password provided is too weak.',
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("email-already-in-use",
            'The account already exists for that email.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
