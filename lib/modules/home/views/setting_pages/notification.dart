
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/notification_controller.dart';
import 'package:wismod/theme/global_widgets.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});
  final notificationController = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Notifications",
        style: TextStyle(
            fontFamily: "Gotham",
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.black),
      )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 0.0),
        child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Column(children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Chat Updates",
                        style: TextStyle(
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      Obx(
                        () => ThemedSwitch(
                            value:
                                notificationController.isChatNotification.value,
                            onChanged: notificationController.toggleSwitchChat),
                      )
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Event updates",
                        style: TextStyle(
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      Obx(() => ThemedSwitch(
                          value:
                              notificationController.isEventNotification.value,
                          onChanged:
                              notificationController.toggleSwitchNotification))
                    ],
                  )),
            ]))),
      ),
    );
  }
}
