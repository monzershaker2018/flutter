import 'package:get/get_navigation/src/root/internacionalization.dart';

class LocalTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          "homepage": "الصفحة الرئيسية",
          "arabic": " عربي",
          "english": " إنجليزي",
        },
        'en': {
          "homepage": "homepage ",
          "arabic": " arabic",
          "english": " english",
        },
      };
}
