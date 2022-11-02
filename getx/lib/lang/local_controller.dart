import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LocalController extends GetxController {
  Locale? locale;
  updateLang(String langcode) {
    locale = Locale(langcode);
    Get.updateLocale(locale!);
  }
}
