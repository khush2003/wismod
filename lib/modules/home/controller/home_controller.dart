import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';

class HomeController extends GetxController {
  final _auth = AuthController.instance;
  final selectedCategory = 'Default'.obs;

  final categoryOptions = [
    'Default',
    'Competition',
    'Tutoring',
    'Sports',
    'Hanging Out',
    'Other',
  ];
  void setSelectedCategory(String? value) {
    selectedCategory(value ?? '');
  }

  void logOut() {
    _auth.logout();
  }
}
