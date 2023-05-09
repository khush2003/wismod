import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/modules/home/controller/home_controller.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

class EventDetailController extends GetxController {
  final firestore = FirebaseService();
  final Rx<Event> eventData = Event.empty().obs;
  final isLoading = true.obs;
  final _auth = AuthController.instance;
  final Rx<bool> isJoined = false.obs;
  final Rx<bool> isUpvoted = false.obs;
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
       Get.snackbar("Sucess!", 'You have sucessfully reported this event',
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
      Get.snackbar("Sucess!", 'You have sucessfully joined this event',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar("Error!", e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
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
        tags(eventData.value.tags);
        isLoading(false);
      }
      updateHomeScreen();
    } finally {}
  }

  void updateHomeScreen() {
    try {
      final c = Get.find<HomeController>();
      c.fetchEvents();
    } finally {}
  }
}
