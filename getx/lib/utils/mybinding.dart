// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:getx/controller/homecontroller.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    // injection dependencies
    Get.put(HomeController());
  }
}
