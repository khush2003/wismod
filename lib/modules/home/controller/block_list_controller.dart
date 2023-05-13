import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';


import 'chat_controller.dart';

class BlockListController extends GetxController {
  final _chat = ChatController.instance;

  void unblockChatGroup(String eventId) async {
    final event = EventsController.instance;
    final eventToUnblock = event.events.where((event) => event.id == eventId).first;
    _chat.unblockChatGroup(eventToUnblock);
  }
}
