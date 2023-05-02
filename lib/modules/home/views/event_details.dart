import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/event_detail_controller.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../shared/models/event.dart';

class EventDetailView extends StatelessWidget {
  EventDetailView({super.key});
  final controller = Get.put(EventDetailController());
  Event eventData() => controller.eventData.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.report)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.bookmark_add_outlined))
          ],
        ),
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(sideWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (controller.eventData.value.imageUrl != null)
                      ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(eventData().imageUrl!,
                              fit: BoxFit.cover)),
                    addVerticalSpace(20),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceBetween,
                      runAlignment: WrapAlignment.spaceBetween,
                      runSpacing: 10,
                      spacing: 10,
                      children: [
                        Text(eventData().title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        if (eventData().numJoined != null)
                          Text(
                              'Members: ${eventData().numJoined}/${eventData().totalCapacity}',
                              style: Theme.of(context).textTheme.displayMedium)
                      ],
                    ),
                    addVerticalSpace(20),
                    Text(
                      "Category: ${eventData().category}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    addVerticalSpace(20),
                    const Text(
                      "Tags",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    addVerticalSpace(),
                    const Text("No Tags Found"),
                    // TODO: tags
                    addVerticalSpace(20),
                    Text("${eventData().upvotes} upvotes"),
                    addVerticalSpace(20),
                    if (eventData().eventDate != null)
                      Text(
                        'Date: ${eventData().eventDate}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    addVerticalSpace(20),
                    Text(
                      'Location: ${eventData().loacation}',
                    ),
                    addVerticalSpace(20),
                    if (eventData().description != null)
                      Text(
                        '${eventData().description}',
                      ),
                    addVerticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: OutlineButtonMedium(
                            child: const Text("Upvote"),
                            onPressed: () {},
                          ),
                        ),
                        addHorizontalSpace(16),
                        Expanded(
                          child: PrimaryButtonMedium(
                              child: const Text('Join'), onPressed: () {}),
                        )
                      ],
                    ),
                    addVerticalSpace(20),
                    ChatBox(controller: controller),
                  ],
                ),
              ))));
  }
}

class ChatBox extends StatelessWidget {
  const ChatBox({super.key, required this.controller});
  final EventDetailController controller;
  Event eventData() => controller.eventData.value;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 219, 232, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(sideWidth),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (eventData().eventOwner.userPhotoUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          eventData().eventOwner.userPhotoUrl!,
                          // Image size adjustment here
                          width: 82,
                          height: 82,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
                addHorizontalSpace(10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        eventData().eventOwner.name,
                        style: const TextStyle(
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 22),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      addVerticalSpace(5),
                      Text(
                        eventData().eventOwner.department,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      addVerticalSpace(5),
                      Text(
                        'Year: ${eventData().eventOwner.year}',
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SecondaryButtonMedium(
                    child: const Text("Chat"), onPressed: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}
