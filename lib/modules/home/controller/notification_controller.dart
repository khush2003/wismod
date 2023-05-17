import 'package:get/get.dart';

class NotificationController extends GetxController {
  final isChatNotification = true.obs;
  final isEventNotification = true.obs;

  toggleSwitchChat(bool value) {
    isChatNotification(value);
  }
  toggleSwitchNotification(bool value){
    isEventNotification(value);
  }
}
