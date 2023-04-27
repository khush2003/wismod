import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LogInController extends GetxController {
  final isvisible = false.obs;

  void toogleVisible() {
    isvisible(!isvisible.value);
  }
}
