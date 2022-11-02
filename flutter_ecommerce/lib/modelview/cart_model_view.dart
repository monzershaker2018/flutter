import 'package:flutter_ecommerce/helper/cart_provider.dart';
import 'package:flutter_ecommerce/model/product_provider_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class CartModelView extends GetxController {
  CartProvider cartProvider = CartProvider();
  List<ProductProviderModel> listCarts = [];

  CartModelView() {
    getAllCarts();
  }

  getAllCarts() async {
    listCarts = await cartProvider.getProducts();
    update();
  }

  addCart(ProductProviderModel productProviderModel) async {
    try {
      var helper = await cartProvider.database;
      await helper.insert(
        'cart',
        productProviderModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      update();
    } on Error {
      throw Error();
    }
  }
}
