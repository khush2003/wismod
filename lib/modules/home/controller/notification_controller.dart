import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController extends GetxController {
  final isChatNotification = true.obs;
  final isEventNotification = true.obs;

  toggleSwitchChat(bool value) {
    isChatNotification(value);
  }

  toggleSwitchNotification(bool value) {
    isEventNotification(value);
  }
}
