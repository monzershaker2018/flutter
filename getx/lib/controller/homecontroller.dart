import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var count = 0;
  SharedPreferences? preferences;

  void increment() {
    count++;
    update();
  }

  decrement() {
    count--;
    update();
  }
}
