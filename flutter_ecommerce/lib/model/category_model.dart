// ignore_for_file: prefer_const_constructors

class CategoryModel {
  String? categoryId, name, imageurl;

  CategoryModel({this.categoryId, this.name, this.imageurl});

  CategoryModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    imageurl = map['imageurl'];
  }

  toJson() {
    return {
      'name': name,
      'imageurl': imageurl,
    };
  }
}
