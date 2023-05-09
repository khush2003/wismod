import 'dart:developer';

import 'package:flutter/material.dart';
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
  final RxList<Event> filteredEvents = <Event>[].obs;
  late List<String> categoryOptions;
  final RxList<Event> joinedChatGroupDetails = <Event>[].obs;
  final RxMap<String, Message> latestMessage = <String, Message>{}.obs;
  final TextEditingController searchController = TextEditingController();

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

  void searchEvents() {
    if (searchController.text.isEmpty) {
      filteredEvents(events.toList());
    }

    final lowercaseSearchString = searchController.text.toLowerCase();

    final filterEvents = events.where((event) {
      final lowercaseTitle = event.title.toLowerCase();
      final lowercaseDescription = event.description.toLowerCase();
      final lowercaseCategory = event.category.toLowerCase();
      final lowercaseEventOwner = event.eventOwner.name.toLowerCase();
      final lowercaseTags =
          event.tags?.map((tag) => tag.toLowerCase()).toList() ?? [];

      if (lowercaseTitle.contains(lowercaseSearchString) ||
          lowercaseDescription.contains(lowercaseSearchString) ||
          lowercaseCategory.contains(lowercaseSearchString) ||
          lowercaseEventOwner.contains(lowercaseSearchString)) {
        return true;
      }

      for (final tag in lowercaseTags) {
        if (tag.contains(lowercaseSearchString)) {
          return true;
        }
      }

      return false;
    }).toList();

    filteredEvents(filterEvents);
  }

  Future<void> fetchEvents() async {
    try {
      isLoading(true);
      final eventsTemp = await firestore.getEvents();
      if (eventsTemp.isNotEmpty) {
        events(eventsTemp);
        filteredEvents(eventsTemp);
        searchController.text = '';
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
