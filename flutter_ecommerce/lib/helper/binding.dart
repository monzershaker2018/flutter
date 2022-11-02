import 'package:flutter_ecommerce/modelview/auth_view_model.dart';
import 'package:flutter_ecommerce/modelview/cart_model_view.dart';
import 'package:flutter_ecommerce/modelview/home_model_view.dart';
import 'package:get/get.dart';

class Biniding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => HomeModelView());
    Get.lazyPut(() => CartModelView());
  }
}
