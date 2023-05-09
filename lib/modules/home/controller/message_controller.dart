import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wismod/shared/models/message.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';

class MessageController extends GetxController {
  final firestore = FirebaseService();
  final Rx<Message> messageData = Message.empty().obs;
  final isLoading = true.obs;
  final RxList<Message> events = <Message>[].obs;

  final imageUrl = ''.obs;
  final userId = ''.obs;
  final _auth = AuthController.instance;

  final TextEditingController messageTextController = TextEditingController();

  @override
  void onReady() async {
    fetchEvent();
    super.onReady();
  }

  void fetchEvent() async {
    try {
      isLoading(true);
      var messageTemp = await firestore
          .getMessage(Get.parameters['id'] ?? '2l8UVLQgFin3dthssdlI');
      if (messageTemp != null) {
        messageData(messageTemp);
        isLoading(false);
      }
    } finally {}
  }

  void createMessage() async {
    try {
      final eventOwner = _auth.appUser.value;
      final message = Message(
        message: messageTextController.text,
        userId: eventOwner.uid!,
        imageUrl: imageUrl.value,
      );
      await FirebaseService().addMessage(message);
    } catch (e) {
      Get.snackbar('Error', 'Message has not been sent!',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
