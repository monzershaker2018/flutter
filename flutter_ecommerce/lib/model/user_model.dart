class UserModel {
  String? uid, name, email, pic;
  UserModel({this.uid, this.name, this.email, this.pic});
  
  UserModel.fromJson(Map<dynamic, dynamic> map) {
    uid = map['uid'];
    name = map['name'];
    email = map['email'];
    pic = map['pic'];
  }
  toJson() {
    // convert data to json
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'pic': pic,
    };
  }
}
