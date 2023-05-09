import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/modules/home/controller/all_pages_nav_controller.dart';
import 'package:wismod/modules/home/controller/home_controller.dart';
import 'package:wismod/routes/routes.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/utils/app_utils.dart';

class EventDetailController extends GetxController {
  final firestore = FirebaseService();
  final Rx<Event> eventData = Event.empty().obs;
  final isLoading = true.obs;
  final _auth = AuthController.instance;
  final Rx<bool> isJoined = false.obs;
  final Rx<bool> isUpvoted = false.obs;
  final Rx<bool> isBookmarked = false.obs;
  final tags = <String>[].obs;

  @override
  void onReady() async {
    fetchEvent();

    super.onReady();
  }

  void setIsUpvoted() {
    if (_auth.appUser.value.upvotedEvents != null) {
      _auth.appUser.value.upvotedEvents!.contains(eventData.value.id)
          ? isUpvoted(true)
          : isUpvoted(false);
    }
  }

  void setIsJoined() {
    if (_auth.appUser.value.joinedEvents != null) {
      _auth.appUser.value.joinedEvents!.contains(eventData.value.id)
          ? isJoined(true)
          : isJoined(false);
    }
  }

  void setIsBookmarked() {
    if (_auth.appUser.value.bookmarkedEvents != null) {
      _auth.appUser.value.bookmarkedEvents!.contains(eventData.value.id)
          ? isBookmarked(true)
          : isBookmarked(false);
    }
  }

  void upvoteEvent() async {
    try {
      await firestore.upvoteEvent(
          _auth.firebaseUser.value!.uid, eventData.value.id!);
      await _auth.updateUser();
      fetchEvent(); //TODO: try to make it faster
      Get.snackbar("Sucess!", 'You have sucessfully upvoted this event',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar("Error!", e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  void reportEvent() async {
    try {
      await firestore.reportEvent(eventData.value.id!);
      fetchEvent();
      Get.snackbar("Sucess!", 'You have sucessfully reported this event!',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar("Error!", e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  void joinEvent() async {
    try {
      //todo: Check if user exists
      await firestore.joinEvent(
          _auth.firebaseUser.value!.uid, eventData.value.id!);
      await _auth.updateUser();
      setIsJoined();
      sucessSnackBar('You have sucessfully joined this event');
    } catch (e) {
      errorSnackBar(e.toString());
    }
  }

  void bookmarkEvent() async {
    try {
      //todo: Check if user exists
      await firestore.bookmarkEvent(
          _auth.firebaseUser.value!.uid, eventData.value.id!);
      await _auth.updateUser();
      setIsBookmarked();
      sucessSnackBar('You have sucessfully bookmarked this event');
    } catch (e) {
      errorSnackBar(e.toString());
    }
  }

  void fetchEvent() async {
    try {
      isLoading(true);
      var eventTemp = await firestore
          .getEvent(Get.parameters['id'] ?? '2l8UVLQgFin3dthssdlI');
      if (eventTemp != null) {
        eventData(eventTemp);
        setIsJoined();
        setIsUpvoted();
        setIsBookmarked();
        tags(eventData.value.tags);
        isLoading(false);
      }
      updateHomeScreen();
    } finally {}
  }

  void chatGroupAdd() async {
    try {
      await firestore.joinChatGroup(
          _auth.firebaseUser.value!.uid, eventData.value.id!);
      Get.toNamed(Routes.chatting, parameters: {'id': eventData.value.id!});
      sucessSnackBar("Joined ChatGroup Sucessfully!");
      try {
        //TODO: Fix no Update event when adding event through eventDetails
        await _auth.updateUser();
        updateHomeScreen();
      } finally {}
    } catch (e) {
      errorSnackBar("There was an error");
    }
  }

  void updateHomeScreen() {
    try {
      final c = HomeController.instance;
      c.fetchEvents();
    } finally {}
  }
}
