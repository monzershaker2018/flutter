// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modelview/home_model_view.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class CustomButtonSheet extends GetWidget<HomeModelView> {
  const CustomButtonSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.explore),
          activeIcon: Text('Explore'),
        ),
        BottomNavigationBarItem(
          activeIcon: Text('Cart'),
          label: '',
          icon: Icon(Icons.shop),
        ),
        BottomNavigationBarItem(
            activeIcon: Text('Account'), label: '', icon: Icon(Icons.person)),
      ],
      currentIndex: controller.bottonvalue,
      onTap: (index) {
        controller.changeBottonValue(index);
        if (index == 0) {
          Get.toNamed('home');
        }
        if (index == 1) {
          Get.toNamed('cart');
        }
        if (index == 2) {
          Get.toNamed('profile');
        }
      },
    );
  }
}
