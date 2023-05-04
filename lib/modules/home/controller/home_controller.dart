import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

import '../../../shared/models/event.dart';

class HomeController extends GetxController {
  final _auth = AuthController.instance;
  final selectedCategory = 'Default'.obs;
  final firestore = FirebaseService();
  final isLoading = true.obs;
  final RxList<Event> events = <Event>[].obs;

  late List<String> categoryOptions = [
    'Default',
    'Competition',
    'Tutoring',
    'Sports',
    'Hanging Out',
    'Thesis'
        'Other',
  ];
  @override
  void onReady() async {
    categoryOptions = await firestore.getCategories() ?? categoryOptions;
    fetchEvents();
    super.onReady();
  }

  void fetchEvents() async {
    try {
      isLoading(true);
      final eventsTemp = await firestore.getEvents();
      if (eventsTemp.isNotEmpty) {
        events(eventsTemp);
        isLoading(false);
      }
    } finally {}
  }

  void setSelectedCategory(String? value) {
    selectedCategory(value ?? '');
  }

  void logOut() {
    _auth.logout();
  }
}
