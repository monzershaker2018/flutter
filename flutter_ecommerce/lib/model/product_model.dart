// ignore_for_file: prefer_const_constructors

class ProductModel {
  String? name, imageurl, size, color, price, description;

  ProductModel(
      {this.name,
      this.imageurl,
      this.size,
      this.color,
      this.description,
      this.price});

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    imageurl = map['imageurl'];
    size = map['size'];
    color = map['color'];
    description = map['description'];
    price = map['price'];
  }

  toJson() {
    return {
      'name': name,
      'imageurl': imageurl,
      'size': size,
      'color': color,
      'price': price,
      'description': description,
    };
  }
}
