import 'dart:developer';

import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/shared/models/message.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

import '../../../shared/models/event.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final _auth = AuthController.instance;
  final selectedCategory = 'Default'.obs;
  final firestore = FirebaseService();
  final isLoading = true.obs;
  final RxList<Event> events = <Event>[].obs;
  late List<String> categoryOptions;
  final RxList<Event> joinedChatGroupDetails = <Event>[].obs;
  final RxMap<String, Message> latestMessage = <String, Message>{}.obs;

  @override
  void onReady() async {
    categoryOptions = await firestore.getCategories() ?? [];
    fetchEvents();
    super.onReady();
  }

  Future<void> _addJoinedChatGroupData() async {
    if (_auth.appUser.value.joinedChatGroups != null &&
        _auth.appUser.value.joinedChatGroups!.isNotEmpty) {
      for (String eventId in _auth.appUser.value.joinedChatGroups!) {
        for (Event e in events) {
          if (e.id == eventId) {
            joinedChatGroupDetails.add(e);
            final latestMessageEvent =
                await firestore.getLatestMessage(eventId) ?? Message.empty();
            latestMessage.addAll({eventId: latestMessageEvent});
          }
        }
      }
    }
  }

  Future<void> fetchEvents() async {
    try {
      isLoading(true);
      final eventsTemp = await firestore.getEvents();
      if (eventsTemp.isNotEmpty) {
        events(eventsTemp);
        await _addJoinedChatGroupData();
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
