// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:get/get.dart';

import 'package:wismod/routes/routes.dart';

import 'package:wismod/modules/home/controller/home_controller.dart';

import '../../../shared/models/event.dart';
import '../../../theme/theme_data.dart';
import '../controller/chat_controller.dart';

class ChatRoomView extends StatelessWidget {
  ChatRoomView({super.key});
  final homeController = Get.put(HomeController());
  final _chat = ChatController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Obx(
          () => homeController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(sideWidth),
                  child: SizedBox(
                      child: Obx(
                    () => _chat.joinedChatGroupsWithoutBlocks.length == 0
                        ? Center(
                            child: const Text(
                                'You have not joined any chat group!'))
                        : Obx(() => ListView.builder(
                              itemCount:
                                  _chat.joinedChatGroupsWithoutBlocks.length,
                              itemBuilder: (context, index) {
                                return ChatEvent(
                                    event: _chat
                                        .joinedChatGroupsWithoutBlocks[index]);
                              },
                            )),
                  )),
                ),
        ));
  }
}

AppBar _buildAppBar() {
  return AppBar(
    title: const Text(
      "JOINED CHAT GROUPS",
      style: TextStyle(fontSize: 22, color: Colors.black),
    ),
    centerTitle: true,
    toolbarHeight: 80,
  );
}

class ChatEvent extends StatelessWidget {
  final Event event;
  final _chat = ChatController.instance;
  ChatEvent({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: primary,
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.chatting, parameters: {'id': event.id!});
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              height: 100,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: Image.network(
                      event.imageUrl ?? placeholderImageEventButE,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.network(
                            placeholderImageEventButE,
                            fit: BoxFit.cover,
                          ),
                      fit: BoxFit.cover)),
            ),
            addHorizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  addVerticalSpace(5),
                  Obx(() => _chat.latestMessages[event.id!] != null
                      ? Text(
                          _chat.latestMessages[event.id!]!.userName != ''
                              ? '${_chat.latestMessages[event.id!]!.userName}: ${_chat.latestMessages[event.id!]!.message}'
                              : '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Container()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
