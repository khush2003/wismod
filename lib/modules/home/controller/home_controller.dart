import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';

class HomeController extends GetxController {
  final _auth = AuthController.instance;

  void logOut() {
    _auth.logout();
  }
}
