import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/model/category_model.dart';
import 'package:flutter_ecommerce/model/product_model.dart';
import 'package:get/get.dart';

class HomeModelView extends GetxController {
  List<CategoryModel> categoriesList = [];
  var categoriesRef = FirebaseFirestore.instance.collection('Categories');
  //
  List<ProductModel> productsList = [];
  var productsRef = FirebaseFirestore.instance.collection('Products');
  //

  int bottonvalue = 0;

  changeBottonValue(int value) {
    bottonvalue = value;
    update();
  }

  HomeModelView() {
    getAllCategories();
    getAllProducts();
    //  print(categoriesList);
  }
  getAllCategories() {
    categoriesRef.get().then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        categoriesList.add(CategoryModel.fromJson(value.docs[i].data()));
      }
      update();
    });
  }

  getAllProducts() {
    productsRef.get().then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        // add data to product list
        productsList.add(ProductModel.fromJson(value.docs[i].data()));
      }
      update();
    });
  }
}
