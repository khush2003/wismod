import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/views/chat_room.dart';
import 'package:wismod/modules/home/views/home.dart';
import 'package:wismod/modules/home/views/settings.dart';

import '../controller/all_pages_nav_controller.dart';
import 'dashboard.dart';
import 'admin.dart';

class AllPagesNav extends StatelessWidget {
  AllPagesNav({super.key});
  final k = Get.put(AllPagesNavController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Obx(() => IndexedStack(
                  index: k.tabIndex.value,
                  children: [
                    HomeView(),
                    ChatRoomView(),
                    DashboardView(),
                    const SettingsView(),
                    const AdminView()
                  ],
                ))),
        bottomNavigationBar: Obx(() => NavigationBar(
            onDestinationSelected: k.changeTabIndex,
            selectedIndex: k.tabIndex.value,
            destinations: k.checkIsAdmin()
                ? const [
                    NavigationDestination(
                        icon: Icon(Icons.home), label: "Home"),
                    NavigationDestination(
                        icon: Icon(Icons.chat_rounded), label: "Chat"),
                    NavigationDestination(
                        icon: Icon(Icons.dashboard), label: "Dashboard"),
                    NavigationDestination(
                        icon: Icon(Icons.settings), label: "Settings"),
                    NavigationDestination(
                        icon: Icon(Icons.admin_panel_settings), label: "Admin"),
                  ]
                : const [
                    NavigationDestination(
                        icon: Icon(Icons.home), label: "Home"),
                    NavigationDestination(
                        icon: Icon(Icons.chat_rounded), label: "Chat"),
                    NavigationDestination(
                        icon: Icon(Icons.dashboard), label: "Dashboard"),
                    NavigationDestination(
                        icon: Icon(Icons.settings), label: "Settings"),
                  ])));
  }
}
