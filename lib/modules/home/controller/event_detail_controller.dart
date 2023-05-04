import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

class EventDetailController extends GetxController {
  final firestore = FirebaseService();
  final Rx<Event> eventData = Event.empty().obs;
  final isLoading = true.obs;
  final _auth = AuthController.instance;
  final Rx<bool> isJoined = false.obs;
  final tags = <String>[].obs;

  @override
  void onReady() async {
    fetchEvent();
    super.onReady();
  }

  void setIsJoined() {
    if (_auth.appUser.value.joinedEvents != null) {
      _auth.appUser.value.joinedEvents!.contains(eventData.value.id)
          ? isJoined(true)
          : isJoined(false);
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
        tags(eventData.value.tags);
        isLoading(false);
      }
    } finally {}
  }
}
