// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controller/homecontroller.dart';

class First extends StatelessWidget {
  const First({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: Text("page 1")),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () => controller.increment(),
              child: Text(
                '+',
                style: TextStyle(fontSize: 25),
              )),
          GetBuilder<HomeController>(
            builder: (controller) => Text(
              "${controller.count}",
              style: TextStyle(fontSize: 25),
            ),
          ),
          TextButton(
              onPressed: () {
                controller.decrement();
              },
              child: Text(
                '-',
                style: TextStyle(fontSize: 25),
              )),
        ],
      )),
    );
  }
}
