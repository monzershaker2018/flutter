import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/model/user_model.dart';

class UserService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  addUser(UserModel userModel) async {
    await userCollection.add(userModel.toJson());
  }
}
