// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:get/get.dart';

import 'package:wismod/routes/routes.dart';

import 'package:wismod/modules/home/controller/home_controller.dart';

import '../../../shared/models/event.dart';
import '../controller/chat_controller.dart';

class ChatRoomView extends StatelessWidget {
  ChatRoomView({super.key});
  final homeController = Get.put(HomeController());
  final _chat = ChatController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "CHAT ROOMS",
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(201, 173, 255, 1),
          toolbarHeight: 100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: Obx(
          () => homeController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(sideWidth),
                  child: SizedBox(
                    child: Obx(() => ListView.builder(
                          itemCount: _chat.joinedChatGroupsWithoutBlocks.length,
                          itemBuilder: (context, index) {
                            return ChatEvent(
                                event:
                                    _chat.joinedChatGroupsWithoutBlocks[index]);
                          },
                        )),
                  ),
                ),
        ));
  }
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
      decoration: BoxDecoration(
        color: Theme.of(context).navigationBarTheme.backgroundColor,
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(107, 41, 237, 1),
              offset: Offset(0, 4),
              blurRadius: 6),
        ],
      ),
      child: OutlinedButton(
        // Route to the Chatting Page
        onPressed: () {
          Get.toNamed(Routes.chatting, parameters: {'id': event.id!});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (event.imageUrl != null)
                  SizedBox(
                    width: 100,
                    height: 75,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(event.imageUrl ?? placeholderImage,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.network(
                                  placeholderImage,
                                  fit: BoxFit.cover,
                                ),
                            fit: BoxFit.cover)),
                  ),
                addHorizontalSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        event.title,
                        style: const TextStyle(
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      addVerticalSpace(5),
                      Text(
                        'Owner: ${event.eventOwner.name}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            addVerticalSpace(10),
            Obx(() => _chat.latestMessages[event.id!] != null
                ? Text(
                    _chat.latestMessages[event.id!]!.userName != ''
                        ? '${_chat.latestMessages[event.id!]!.userName}: ${_chat.latestMessages[event.id!]!.message}'
                        : '',
                    style: const TextStyle(
                      fontFamily: "Gotham",
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  )
                : Container()),
            addVerticalSpace(10),
          ],
        ),
      ),
    );
  }
}
