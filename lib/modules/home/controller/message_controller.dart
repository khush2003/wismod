import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/home_controller.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/models/message.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';

class MessageController extends GetxController {
  final firestore = FirebaseService();
  final RxList<Message> messages = <Message>[].obs;
  final isLoading = true.obs;
  final _auth = AuthController.instance;
  final Rx<Event> eventData = Event.empty().obs;

  final TextEditingController messageTextController = TextEditingController();

  @override
  void onInit() async {
    fetchMessages();
    super.onInit();
  }

  void fetchMessages() async {
    try {
      final eventId = Get.parameters['id'] ?? '2l8UVLQgFin3dthssdlI';
      isLoading(true);
      var messageTemp = await firestore.getMessages(eventId);
      var eventTemp = await firestore.getEvent(eventId);
      if (eventTemp != null) {
        eventData(eventTemp);
        messages(messageTemp);
        isLoading(false);
      }
    } finally {}
  }

  void createMessage() async {
    try {
      isLoading(true);
      final message = Message(
        profilePicture: _auth.appUser.value.profilePicture,
        userName: _auth.appUser.value.getName(),
        sentOn: DateTime.now(),
        eventId: Get.parameters['id'] ?? '2l8UVLQgFin3dthssdlI',
        message: messageTextController.text,
        sentBy: _auth.firebaseUser.value!.uid,
      );
      await FirebaseService().addMessage(message);
      fetchMessages();
      messageTextController.text = "";
      await HomeController.instance.fetchEvents();
    } catch (e) {
      Get.snackbar('Error', 'Message has not been sent!',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
    isLoading(false);
  }
}
