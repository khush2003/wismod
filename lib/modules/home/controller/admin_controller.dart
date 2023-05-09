import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

import '../../../shared/models/event.dart';

class AdminController extends GetxController {
  final _auth = AuthController.instance;
  final selectedCategory = 'Default'.obs;
  final firestore = FirebaseService();
  final isLoading = true.obs;
  final RxList<Event> events = <Event>[].obs;
  final List<Event> _reportedEvents = [];

  List<Event> get reportedEvents => _reportedEvents;
  late List<String> categoryOptions;

  @override
  void onReady() async {
    categoryOptions = await firestore.getCategories() ?? [];
    fetchEvents();
    super.onReady();
  }

  void fetchEvents() async {
    try {
      isLoading(true);
      final eventsTemp = await firestore.getEvents();
      if (eventsTemp.isNotEmpty) {
        _reportedEvents.clear();
        _reportedEvents
            .addAll(eventsTemp.where((event) => event.isReported == true));
        isLoading(false);
      }
    } finally {}
  }

  void logOut() {
    _auth.logout();
  }
}
