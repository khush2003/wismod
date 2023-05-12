import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/home_controller.dart';
import '../../../shared/models/event.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

class ProfilePictureController extends GetxController {
  final imageUrl = ''.obs;

  final dateTime = DateTime.now().obs;
  final _firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();
  final _auth = AuthController.instance;

  bool setProfilePicture() {
    bool isPassed = false;
    final firestore = FirebaseService();
    try {
      firestore.updateProfilePicture(
          _auth.firebaseUser.value!.uid, imageUrl.value);
      return !isPassed;
    } catch (e) {
      Get.snackbar("Error",
          "An unknown error occured! Please make sure to login and select a proper image file!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return isPassed;
    }
  }

  uploadImage() async {
    //Check Permissions
    //Select Image
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var file = File(image.path);
      //Upload to Firebase
      var snapshot = await _firebaseStorage
          .ref()
          .child('images/${image.name}')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrl(downloadUrl);
    } else {
      Get.snackbar("Error!", "No image chosen or image corrupted");
      return;
    }
  }
}

class FourButtonsController extends GetxController {
  var showUpcoming = false.obs;
  var showRequested = false.obs;
  var showBookmarked = false.obs;
  var showOwn = false.obs;

  final firestore = FirebaseService();
  final isLoading = true.obs;
  final RxList<Event> events = <Event>[].obs;
  final RxList<Event> _ownedEvents = <Event>[].obs;
  final RxList<Event> _joinedEvents = <Event>[].obs;
  final RxList<Event> _bookmarkedEvents = <Event>[].obs;
  final RxList<Event> _upcomingEvents = <Event>[].obs;
  final auth = AuthController.instance;

  List<Event> get ownedEvents => _ownedEvents;
  List<Event> get upcomingEvents => _upcomingEvents;
  List<Event> get bookmarkedEvents => _bookmarkedEvents;
  List<Event> get joinedEvents => _joinedEvents;

  @override
  void onInit() {
    super.onInit();
    initializeData(); //Wait till you get all the data from database (Using this )
    ever(HomeController.instance.events,
        _setEvents); //Whenever events in home changes, this also changes
  }

  Future<void> initializeData() async {
    try {
      isLoading(true);
      final eventsTemp = await firestore
          .getEvents(); // Get events to make sure all data like user data is gotten from firebase
      if (eventsTemp.isNotEmpty) {
        _setEvents(eventsTemp);
      }
    } finally {}
  }

  void _setEvents(List<Event> eventList) {
    isLoading(true); // Set Is loading to make sure ui refresh
    events(eventList);
    setOwnedEvents();
    setBookmarkedEvents();
    setUpcomingEvents();
    isLoading(false);
  }

  void toggleUpcoming() {
    showUpcoming.value = !showUpcoming.value;
  }

  void toggleRequested() {
    showRequested.value = !showRequested.value;
  }

  void toggleBookmarked() {
    showBookmarked.value = !showBookmarked.value;
  }

  void toggleOwn() {
    showOwn.value = !showOwn.value;
  }

  void setOwnedEvents() {
    if (events.isNotEmpty) {
      _ownedEvents.clear();
      _ownedEvents.addAll(events.where(
          (event) => event.eventOwner.uid == auth.firebaseUser.value!.uid));
    }
  }

  void setUpcomingEvents() {
    final tempUpcomingEvents = auth.appUser.value.joinedEvents;
    if (tempUpcomingEvents != null && tempUpcomingEvents.isNotEmpty) {
      final List<Event> eventsToUpdate = [];
      for (Event e in events) {
        if (tempUpcomingEvents.contains(e.id)) {
          eventsToUpdate.add(e);
        }
      }
      // So many events are added up to eventsToUpdate.
      //Idk what kinds of error is that.
      //So only the first auth.appUser.value.joinedEvents!.length number of events
      //are correct and i cut them off as follow

      _joinedEvents.assignAll(
          eventsToUpdate.take(auth.appUser.value.joinedEvents!.length));

      // This one is sorting events by date

      _joinedEvents.sort(
          (a, b) => a.eventDate?.compareTo(b.eventDate ?? DateTime.now()) ?? 0);
    }
  }

  void setBookmarkedEvents() {
    final tempBookmarkedEvents = auth.appUser.value.bookmarkedEvents;
    if (tempBookmarkedEvents != null && tempBookmarkedEvents.isNotEmpty) {
      final List<Event> eventsToUpdate = [];
      for (Event e in events) {
        if (tempBookmarkedEvents.contains(e.id)) {
          eventsToUpdate.add(e);
        }
      }
      _bookmarkedEvents.assignAll(
          eventsToUpdate.take(auth.appUser.value.bookmarkedEvents!.length));
    }
  }
}
