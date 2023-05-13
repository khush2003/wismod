import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';
import 'package:wismod/shared/models/message.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

import '../../../shared/models/event.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final _auth = AuthController.instance;
  final _firestore = FirebaseService();
  final _event = EventsController.instance;

  final selectedCategory = 'Default'.obs;

  final isLoading = true.obs;
  // final RxList<Event> events = <Event>[].obs;
  final RxList<Event> filteredEvents = <Event>[].obs;
  late List<String> categoryOptions;
  final RxMap<String, Message> latestMessage = <String, Message>{}.obs;
  final TextEditingController searchController = TextEditingController();
  final currentDateSort = 'None'.obs;

  @override
  void onInit() async {
    categoryOptions = await _firestore.getCategories() ?? [];
    filteredEvents(_event.events);
    isLoading(false);
    super.onInit();
  }

  void filterEventsByCategory(String category) {
    searchController.text = '';
    if (category == 'Default') {
      filteredEvents(_event.events.toList());
    } else {
      final lowercaseCategory = category.toLowerCase();
      final filterEvents = _event.events.where((event) {
        final lowercaseEventCategory = event.category.toLowerCase();
        return lowercaseEventCategory == lowercaseCategory;
      }).toList();
      filteredEvents(filterEvents);
    }
  }
  //TODO: Change cross to save
  void sortEventsByDate() {
    if (currentDateSort.value == 'Ascending') {
      currentDateSort('Descending');
      filteredEvents.sort((a, b) {
        if (a.eventDate == null && b.eventDate == null) {
          return 0;
        } else if (a.eventDate == null) {
          return 1;
        } else if (b.eventDate == null) {
          return -1;
        } else {
          return b.eventDate!.compareTo(a.eventDate!);
        }
      });
    } else {
      currentDateSort('Ascending');
      filteredEvents.sort((a, b) {
        if (a.eventDate == null && b.eventDate == null) {
          return 0;
        } else if (a.eventDate == null) {
          return 1;
        } else if (b.eventDate == null) {
          return -1;
        } else {
          return a.eventDate!.compareTo(b.eventDate!);
        }
      });
    }
  }

  void searchEvents() {
    if (searchController.text.isEmpty) {
      filteredEvents(_event.events.toList());
    }

    final lowercaseSearchString = searchController.text.toLowerCase();

    final filterEvents = _event.events.where((event) {
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

  void setSelectedCategory(String? value) {
    selectedCategory(value ?? 'Default');
    filterEventsByCategory(value ?? 'Default');
  }

  void logOut() {
    _auth.logout();
  }
}
