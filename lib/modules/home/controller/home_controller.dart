import 'dart:developer' as d;
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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
    generateSmartFeed();
    isLoading(false);
    super.onInit();
    /*requestPermission();
    getToken();*/
  }

  void generateSmartFeed() {
    final newFilteredEvents = _event.events.toList();
    final userTags = _event.sortTagsByFrequency();
    sortEventByTagList(newFilteredEvents, userTags);
    randomizeUnvisitedEvents(newFilteredEvents, 5, 2);
    filteredEvents.assignAll(newFilteredEvents);
  }

  void randomizeUnvisitedEvents(
      List<Event> eventsList, int lastFewCount, int interval) {
    if (eventsList.length < interval * lastFewCount) {
      return;
    }

    List<Event> lastFewEvents =
        eventsList.sublist(eventsList.length - lastFewCount);

    // Shuffle the last few events randomly
    Random random = Random();
    lastFewEvents.shuffle(random);

    int index = interval;
    for (int i = 0; i < lastFewEvents.length; i++) {
      try {
        eventsList.remove(lastFewEvents[
            i]); // Remove the event if it already exists in eventsList
        eventsList.insert(index, lastFewEvents[i]);
        index += interval + 1;
      } catch (e) {}
    }
  }

/*  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print('My token is $mtoken');
      });
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: false,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }*/

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

  void sortEventByTagList(List<Event> eventList, List<String> tagList) {
    // Sort the joinedEvents list based on tagList
    eventList.sort((a, b) {
      final aTags = (a.tags ?? []).toSet();
      final bTags = (b.tags ?? []).toSet();

      // Compare the presence of tags from tagList in each event
      for (final tag in tagList) {
        final aHasTag = aTags.contains(tag);
        final bHasTag = bTags.contains(tag);

        // Sort events with the tag first, then those without
        if (aHasTag && !bHasTag) {
          return -1;
        } else if (!aHasTag && bHasTag) {
          return 1;
        }
      }

      // If both events have the same tags from tagList, sort by event upvotes
      return b.upvotes.compareTo(a.upvotes);
    });
  }
}
