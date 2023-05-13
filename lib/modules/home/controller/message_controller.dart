import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/chat_controller.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/models/message.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';

class MessageController extends GetxController {
  final RxList<Message> messages = <Message>[].obs;
  final isLoading = true.obs;
  final _auth = AuthController.instance;
  final _event = EventsController.instance;
  final _chat = ChatController.instance;
  final _firestore = FirebaseService();
  final Rx<Event> eventData = Event.empty().obs;

  final TextEditingController messageTextController = TextEditingController();

  @override
  void onInit() async {
    await _initialize();
    super.onInit();
  }

  Future<void> fetchMessages(Event event) async {
    messages.clear();
    try {
      var messageTemp = await _firestore.getMessages(event.id!);
      messages(messageTemp);
    } finally {}
  }

  Future<void> _initialize() async {
    isLoading(true);
    final eventId = Get.parameters['id'] ?? '2l8UVLQgFin3dthssdlI';
    eventData(_event.events.where((event) => event.id == eventId).first);
    await fetchMessages(eventData.value);
    isLoading(false);
  }

  void blockChatGroup() async {
    _chat.blockChatGroup(eventData.value);
    Get.back();
  }

  void createMessage() async {
    try {
      final message = Message(
        profilePicture: _auth.appUser.value.profilePicture,
        userName: _auth.appUser.value.getName(),
        sentOn: DateTime.now(),
        eventId: Get.parameters['id'] ?? '2l8UVLQgFin3dthssdlI',
        message: messageTextController.text,
        sentBy: _auth.firebaseUser.value!.uid,
      );
      await FirebaseService().addMessage(message);
      messageTextController.text = "";
      messages.add(message);
      ChatController.instance.latestMessages
          .addAll({eventData.value.id!: message});
    } catch (e) {
      Get.snackbar('Error', 'Message has not been sent!',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
