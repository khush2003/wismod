
import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/chat_controller.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/models/message.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/utils/app_utils.dart';

class MessageController extends GetxController {
  final RxList<Message> messages = <Message>[].obs;
  final isLoading = true.obs;
  final _auth = AuthController.instance;
  final _event = EventsController.instance;
  final _chat = ChatController.instance;
  final _firestore = FirebaseService();
  final Rx<Event> eventData = Event.empty().obs;

  final TextEditingController messageTextController = TextEditingController();
  StreamSubscription<List<Message>>? messagesSubscription;

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

    // Subscribe to messages changes
    messagesSubscription = _firestore
        .getMessagesStream(eventData.value.id!)
        .listen((updatedMessages) {
      messages(updatedMessages);
    });
  }

  @override
  void onClose() {
    messagesSubscription
        ?.cancel(); // Cancel the subscription when closing the controller
    super.onClose();
  }

  void blockChatGroup() async {
    _chat.blockChatGroup(eventData.value);
    await FirebaseMessaging.instance.unsubscribeFromTopic(eventData.value.id!);
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
      // messages.add(message);
      ChatController.instance.latestMessages
          .addAll({eventData.value.id!: message});
      /*if(_auth.appUser.value.uid != message.sentBy){
      sendPushMessage(
          eventData.value.id!, _auth.appUser.value.getName()+": "+messageTextController.text, eventData.value.title);
      }*/
    } catch (e) {
      errorSnackBar('Message has not been sent!');
    }
  }

  void sendPushMessage(String event, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAq4O_glM:APA91bG_b1Bqqc3nU0SnJ39DZRjvGz_DFOEcrYFUOB6GUtTn7k7ML8EIva60g4ucTaBb_wSzR6CGtOmjCj9eqo4fUidkQuDJMGYyQl5n51zGyQ5X-x5BnTo9blRSRja-cEFpzSTHKU2P'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'topic': event,
              'body': body,
              'title': title,
              'sound': 'default',
            },
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
              'android channel id': 'dbfood'
            },
            'to': '/topics/$event',
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
  }

  

  /*
  Future<void> setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handlerMessage(context, initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handlerMessage(context, event);
    });
  }
  
  void handlerMessage(BuildContext context, RemoteMessage message) {
    //_initialize();
    final eventId = Get.parameters['id'] ?? '2l8UVLQgFin3dthssdlI';
    eventData(_event.events.where((event) => event.id == eventId).first);
    Get.toNamed(Routes.chatting, parameters: {'id': event.id!});
  }
  */
  
}
