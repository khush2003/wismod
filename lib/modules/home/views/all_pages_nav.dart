import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/views/chat_room.dart';
import 'package:wismod/modules/home/views/home.dart';
import 'package:wismod/modules/home/views/settings.dart';

import '../controller/all_pages_nav_controller.dart';
import 'dashboard.dart';

class AllPagesNav extends StatelessWidget {
  AllPagesNav({super.key});
  final k = Get.put(AllPagesNavController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Obx(() => IndexedStack(
                  index: k.tabIndex.value,
                  children: const [
                    HomeView(),
                    ChatRoomView(),
                    DashboardView(),
                    SettingsView()
                  ],
                ))),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              unselectedItemColor: Colors.black,
              onTap: k.changeTabIndex,
              currentIndex: k.tabIndex.value,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_rounded), label: "Chat"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), label: "Dashboard"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings")
              ]),
        ));
  }
}
