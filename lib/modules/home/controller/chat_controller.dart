import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/routes/routes.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/models/message.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../auth/controllers/auth_controller.dart';
import 'events_controller.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();
  //static ChatController get instance => Get.lazyPut(()=>ChatController();
  final RxList<Event> blockedChatGroups = <Event>[].obs;
  final RxList<Event> joinedChatGroups = <Event>[].obs;
  final RxList<Event> joinedChatGroupsWithoutBlocks = <Event>[].obs;
  final RxMap<String, Message> latestMessages = <String, Message>{}.obs;
  // current event messages etc
  final isInitialzed = false.obs;
  final _eventController = EventsController.instance;

  final _auth = AuthController.instance;

  final _firestore = FirebaseService();
  final _messageStreams = <StreamSubscription>{};

  final Rx<Event> eventData = Event.empty().obs;

  @override
  void onInit() async {
    initializeLists();
    await fetchLatestMessages();
    isInitialzed(true);

    super.onInit();
  }

  void initializeLists() {
    _setBlockedChatGroups();
    _setJoinedChatGroups();
    _setJoinedChatGroupsWithoutBlocks();
  }

  void _setBlockedChatGroups() {
    blockedChatGroups.clear();
    final tempBlockedChatGroups = _auth.user.blockedChatGroups;
    if (tempBlockedChatGroups != null && tempBlockedChatGroups.isNotEmpty) {
      blockedChatGroups.addAll(_eventController.events
          .where((event) => tempBlockedChatGroups.contains(event.id)));
    }
  }

  void _setJoinedChatGroups() {
    joinedChatGroups.clear();
    final tempJoinedChatGroups = _auth.user.joinedChatGroups;
    if (tempJoinedChatGroups != null && tempJoinedChatGroups.isNotEmpty) {
      joinedChatGroups.addAll(_eventController.events
          .where((event) => tempJoinedChatGroups.contains(event.id)));
    }
  }

  void _setJoinedChatGroupsWithoutBlocks() {
    joinedChatGroupsWithoutBlocks.clear();
    for (final event in joinedChatGroups) {
      if (!checkEventInList(event.id!, blockedChatGroups)) {
        joinedChatGroupsWithoutBlocks.add(event);
      }
    }
  }

  Future<void> fetchLatestMessages() async {
    try {
      for (Event event in joinedChatGroupsWithoutBlocks) {
        final messageStream = _firestore.getLatestMessagesStream(event.id!);
        _messageStreams.add(
          messageStream.listen((message) {
            if (message != null) {
              latestMessages[event.id!] = message;
            }
          }),
        );
      }
    } finally {}
  }

  void blockChatGroup(Event eventData) async {
    final event = getEventInList(eventData.id!, _eventController.events);
    if (event == null) {
      return;
    }

    blockedChatGroups.add(event);
    joinedChatGroupsWithoutBlocks.removeWhere((e) => e.id == event.id);
    _auth.appUser.value.blockedChatGroups?.add(event.id!);

    await _firestore.blockChatGroup(_auth.user.uid!, event.id!).catchError((e) {
      blockedChatGroups.removeWhere((e) => e.id == event.id);
      joinedChatGroupsWithoutBlocks.add(event);
      _auth.appUser.value.blockedChatGroups?.remove(event.id!);
      errorSnackBar(
          "Error Connecting to Database, Please check network connection!");
    });
  }

  void unblockChatGroup(Event eventData) async {
    final event = getEventInList(eventData.id!, _eventController.events);
    if (event == null) {
      return;
    }

    blockedChatGroups.removeWhere((e) => e.id == event.id);
    joinedChatGroupsWithoutBlocks.add(event);
    _auth.appUser.value.blockedChatGroups?.remove(event.id!);
    await _firestore
        .unblockChatGroup(_auth.user.uid!, event.id!)
        .catchError((e) {
      blockedChatGroups.add(event);
      joinedChatGroupsWithoutBlocks.removeWhere((e) => e.id == event.id);
      _auth.appUser.value.blockedChatGroups?.add(event.id!);
      errorSnackBar(
          "Error Connecting to Database, Please check network connection!");
    });
  }

  void joinChatGroup(Event eventData) async {
    final event = getEventInList(eventData.id!, _eventController.events);
    if (event == null) {
      return;
    }

    await _firestore.joinChatGroup(_auth.user.uid!, event.id!).catchError((e) {
      errorSnackBar("Unable to join chat group");
      return;
    }).then((value) {
      joinedChatGroups.add(event);
      joinedChatGroupsWithoutBlocks.add(event);
      _auth.appUser.value.joinedChatGroups?.add(event.id!);
      Get.toNamed(Routes.chatting, parameters: {'id': event.id!});
      sucessSnackBar("Joined ChatGroup Sucessfully!");
    });
  }

  void cancelAllSubscriptions() {
    for (final subscription in _messageStreams) {
      subscription.cancel();
    }
    _messageStreams.clear();
  }

  @override
  void onClose() {
    cancelAllSubscriptions();
    super.onClose();
  }

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
    //_message.onInit();
    //onInit();
    /*final eventId = Get.parameters['id'] ?? '2l8UVLQgFin3dthssdlI';
    eventData(_eventController.events.where((event) => event.id == eventId).first);*/
    Get.toNamed(Routes.chatting, parameters: {'id': eventData.value.id!});
  }
}
