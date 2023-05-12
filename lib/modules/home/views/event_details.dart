import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/event_detail_controller.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import '../../../shared/models/event.dart';
import '../../../theme/theme_data.dart';

class EventDetailView extends StatelessWidget {
  EventDetailView({super.key});
  final controller = Get.put(EventDetailController());
  final auth = AuthController.instance;
  Event eventData() => controller.eventData.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            AlertReport(controller: controller),
            IconButton(
                onPressed: () {
                  controller.bookmarkEvent();
                },
                icon: Obx(() => Icon(controller.isBookmarked.value
                    ? Icons.bookmark
                    : Icons.bookmark_add_outlined)))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                      padding: const EdgeInsets.all(sideWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                  eventData().imageUrl ??
                                      'https://perspectives.agf.com/wp-content/plugins/accelerated-mobile-pages/images/SD-default-image.png',
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.network(
                                        'https://perspectives.agf.com/wp-content/plugins/accelerated-mobile-pages/images/SD-default-image.png',
                                        fit: BoxFit.cover,
                                      ),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              if (eventData().members != null &&
                                  eventData().totalCapacity != null)
                                Text(
                                    'Members: ${eventData().members!.length}/${eventData().totalCapacity}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium)
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
                          if (eventData().tags == null ||
                              eventData().tags!.isEmpty)
                            const Text("No Tags Found"),
                          createTags(controller),
                          addVerticalSpace(20),
                          Obx(() => Text("${eventData().upvotes} upvotes")),
                          addVerticalSpace(20),
                          if (eventData().eventDate != null)
                            Text(
                              'Date: ${formatDate(eventData().eventDate!)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          addVerticalSpace(20),
                          Text(
                            'Location: ${eventData().location}',
                          ),
                          addVerticalSpace(20),
                          Text(
                            eventData().description,
                          ),
                          addVerticalSpace(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Obx(() => OutlineButtonMedium(
                                      onPressed: () {
                                        controller.upvoteEvent();
                                      },
                                      child: controller.isUpvoted.value
                                          ? const Text("Remove Upvote")
                                          : const Text("Upvote"),
                                    )),
                              ),
                              addHorizontalSpace(16),
                              auth.appUser.value.isAdmin == true
                                  ? Container()
                                  : Expanded(
                                      child: Obx(() => PrimaryButtonMedium(
                                          onPressed: controller.isJoined.value
                                              ? null
                                              : () {
                                                  controller.joinEvent();
                                                },
                                          child: controller.isJoined.value
                                              ? const Text('Joined')
                                              : const Text('Join'))),
                                    ),
                            ],
                          ),
                          addVerticalSpace(20),
                          ChatBox(controller: controller),
                        ],
                      ),
                    ))),
            ),
            auth.appUser.value.isAdmin == true
                ? Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffECE4FC),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(() => ElevatedButton(
                              onPressed: controller.isJoined.value
                                  ? null
                                  : () {
                                      controller.joinEvent();
                                    },
                              child: controller.isJoined.value
                                  ? const Text('Joined')
                                  : const Text('Join'))),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirmation'),
                                    content: const Text(
                                        'Are you sure you want to remove this event?',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    actions: [
                                      OutlineButtonMedium(
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3.0),
                                          child: Text('Cancel'),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text('Remove'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ));
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        eventData().eventOwner.userPhotoUrl ??
                            'https://perspectives.agf.com/wp-content/plugins/accelerated-mobile-pages/images/SD-default-image.png',
                        errorBuilder: (context, error, stackTrace) =>
                            Image.network(
                          'https://perspectives.agf.com/wp-content/plugins/accelerated-mobile-pages/images/SD-default-image.png',
                          width: 82,
                          height: 82,
                          fit: BoxFit.cover,
                        ),
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
                    child: const Text("Chat"),
                    onPressed: () {
                      controller.chatGroupAdd();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget createTags(EventDetailController controller) {
  final tagsWidgets = <Widget>[];
  for (int i = 0; i < controller.tags.length; i++) {
    tagsWidgets.add(Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: AppThemeData.themedata.colorScheme.primary, width: 2),
          borderRadius: BorderRadius.circular(5)),
      child: Text(controller.tags[i]),
    ));
  }
  return Wrap(
    direction: Axis.horizontal,
    spacing: 10,
    runSpacing: 10,
    children: tagsWidgets,
  );
}

class AlertReport extends StatelessWidget {
  final EventDetailController controller;
  const AlertReport({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                // contentPadding: EdgeInsets.all(24.0),
                title: const Text('Do you want to report this event?',
                    style: TextStyle(
                        fontFamily: "Gotham",
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.black)),
                // content: const Text('AlertDialog description'),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                          child: OutlineButtonMedium(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('No',
                                style: TextStyle(
                                    fontFamily: "Gotham",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Color.fromRGBO(123, 56, 255, 1))),
                          )),
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                          child: OutlineButtonMedium(
                            onPressed: () {
                              controller.reportEvent();
                              Navigator.pop(context, 'Done');
                            },
                            child: const Text('Yes',
                                style: TextStyle(
                                    fontFamily: "Gotham",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Color.fromRGBO(123, 56, 255, 1))),
                          )),
                    ],
                  ),
                ],
              ),
            ),
        icon: const Icon(Icons.report));
  }
}
