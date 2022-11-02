// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/lang/local_controller.dart';
import 'package:getx/utils/mybinding.dart';
import 'package:getx/lang/local.dart';
import 'package:getx/view/page2.dart';
import 'package:getx/view/page3.dart';
import 'package:getx/components/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LocalController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.darkTheme,
      initialRoute: '/',
      initialBinding: MyBinding(),
      locale: LocalController().locale,
      translations: LocalTranslations(),
      getPages: [
        GetPage(name: '/', page: () => Second()),
        GetPage(name: '/home', page: () => Tharid())
      ],
    );
  }
}
