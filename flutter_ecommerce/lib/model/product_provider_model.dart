// ignore_for_file: prefer_const_constructors

class ProductProviderModel {
  String? name, imageurl, quintity;
  int? price;

  ProductProviderModel({this.name, this.imageurl, this.quintity, this.price});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageurl': imageurl,
      'quintity': quintity,
      'price': price,
    };
  }
}
