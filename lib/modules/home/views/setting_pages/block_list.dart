import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/block_list_controller.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/theme/theme_data.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../controller/chat_controller.dart';

class BlockListView extends StatelessWidget {
  BlockListView({super.key});
  final controller = Get.put(BlockListController());
  final _chat = ChatController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Block list",
        style: TextStyle(
            fontFamily: "Gotham",
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.black),
      )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Align(
            alignment: Alignment.topCenter,
            child: Obx(() => _chat.blockedChatGroups.length == 0 ? Center(child: const Text('You have not blocked any chat groups!')) : Obx(() => ListView.separated(
                itemCount: _chat.blockedChatGroups.length,
                itemBuilder: (context, index) {
                  return BlockedPerson(event: _chat.blockedChatGroups[index]);
                },
                separatorBuilder: (context, index) => addVerticalSpace(20))))),
      ),
    );
  }
}

class BlockedPerson extends StatelessWidget {
  final Event event;

  const BlockedPerson({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(sideWidth),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (event.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(
                  event.imageUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.network(
                    placeholderImageEvent,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            addHorizontalSpace(20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                        fontFamily: "Gotham",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  addVerticalSpace(5),
                  Text(
                    event.eventOwner.name,
                    style: const TextStyle(
                        fontFamily: "Gotham",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            //Icon
            CancelBlock(eventId: event.id!),
          ],
        ),
      ),
    );
  }
}

// double _volume = 0.0;

class CancelBlock extends StatelessWidget {
  final String eventId;
  final controller = Get.find<BlockListController>();
  CancelBlock({super.key, required this.eventId});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.cancel_outlined,
        color: secondary,
      ),
      iconSize: 50.0,
      tooltip: 'Remove from block list',
      color: Theme.of(context).colorScheme.secondary,
      onPressed: () => controller.unblockChatGroup(eventId),
    );
  }
}
