import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';


import 'chat_controller.dart';

class BlockListController extends GetxController {
  final _chat = ChatController.instance;

  void unblockChatGroup(String eventId) async {
    final event = EventsController.instance;
    final eventToUnblock = event.events.where((event) => event.id == eventId).first;
    await FirebaseMessaging.instance.subscribeToTopic(eventToUnblock.id!);
    _chat.unblockChatGroup(eventToUnblock);
  }
}
