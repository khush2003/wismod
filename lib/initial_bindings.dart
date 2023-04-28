import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
