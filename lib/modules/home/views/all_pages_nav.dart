import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:unicons/unicons.dart';
import 'package:wismod/modules/home/controller/chat_controller.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';
import 'package:wismod/modules/home/views/chat_room.dart';
import 'package:wismod/modules/home/views/home.dart';
import 'package:wismod/modules/home/views/setting_pages/settings.dart';
import 'package:wismod/theme/theme_data.dart';
import 'package:wismod/utils/uni_icon.dart';

import '../controller/all_pages_nav_controller.dart';
import 'dashboard.dart';
import 'admin.dart';

class AllPagesNav extends StatelessWidget {
  AllPagesNav({super.key});
  final k = Get.put(AllPagesNavController());
  final h = Get.put(EventsController());
  final i = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Obx(() => IndexedStack(
                  index: k.tabIndex.value,
                  children: [
                    HomeScreenView(),
                    ChatRoomView(),
                    DashboardView(),
                    const SettingsView(),
                    AdminView()
                  ],
                ))),
        bottomNavigationBar: Obx(() => DecoratedBox(
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 10))),
              child: SalomonBottomBar(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  backgroundColor: const Color(0xffffffff),
                  itemPadding: const EdgeInsets.all(16),
                  selectedItemColor: primary,
                  onTap: k.changeTabIndex,
                  currentIndex: k.tabIndex.value,
                  items: k.checkIsAdmin()
                      ? [
                          SalomonBottomBarItem(
                              icon: const UnIcon(
                                UniconsLine.estate,
                                size: 20,
                              ),
                              title: const Text("Home")),
                          SalomonBottomBarItem(
                              icon: const UnIcon(
                                UniconsLine.comment,
                                size: 20,
                              ),
                              title: const Text("Chat")),
                          SalomonBottomBarItem(
                              icon: const UnIcon(
                                UniconsLine.apps,
                                size: 20,
                              ),
                              title: const Text("Dashboard")),
                          SalomonBottomBarItem(
                              icon: const UnIcon(
                                UniconsLine.setting,
                                size: 20,
                              ),
                              title: const Text("Settings")),
                          SalomonBottomBarItem(
                              icon: const UnIcon(
                                UniconsLine.shield,
                                size: 20,
                              ),
                              title: const Text("Admin")),
                        ]
                      : [
                          SalomonBottomBarItem(
                              icon: const UnIcon(
                                UniconsLine.estate,
                                size: 20,
                              ),
                              title: const Text("Home")),
                          SalomonBottomBarItem(
                              icon: const UnIcon(
                                UniconsLine.comment,
                                size: 20,
                              ),
                              title: const Text("Chat")),
                          SalomonBottomBarItem(
                              icon: const UnIcon(
                                UniconsLine.apps,
                                size: 20,
                              ),
                              title: const Text("Dashboard")),
                          SalomonBottomBarItem(
                              icon: const UnIcon(
                                UniconsLine.setting,
                                size: 20,
                              ),
                              title: const Text("Settings")),
                        ]),
            )));
  }
}
