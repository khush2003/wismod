import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';


class AdminController extends GetxController {
  final _auth = AuthController.instance;
  final selectedCategory = 'Default'.obs;
  final firestore = FirebaseService();
  final isLoading = true.obs;

  late List<String> categoryOptions;

  @override
  void onReady() async {
    categoryOptions = await firestore.getCategories() ?? [];
    isLoading(false);
    super.onReady();
  }

  void logOut() {
    _auth.logout();
  }
}
