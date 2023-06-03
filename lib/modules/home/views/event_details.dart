import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/event_detail_controller.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';
import 'package:wismod/routes/routes.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import '../../../shared/models/event.dart';
import '../../../shared/models/user.dart';
import '../../../theme/theme_data.dart';
import '../controller/dashboard_controller.dart';
import 'dashboard.dart';

class EventDetailView extends StatelessWidget {
  EventDetailView({super.key});
  final profilePictureController = Get.put(ProfilePictureController());
  final controller = Get.put(EventDetailController());
  final auth = AuthController.instance;
  Event eventData() => controller.eventData.value;
  final _event = EventsController.instance;
  @override
  Widget build(BuildContext context) {
    controller.setMemberList();
    return Scaffold(
        appBar: AppBar(
          actions: [
            if (eventData().eventOwner.uid != auth.user.uid &&
                auth.user.isAdmin == false)
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
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (controller.isOwnedEvent.value) MemberBox(),
                          if (controller.isOwnedEvent.value)
                            addVerticalSpace(20),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                  eventData().imageUrl ?? placeholderImageEvent,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.network(
                                        placeholderImageEvent,
                                        fit: BoxFit.cover,
                                      ),
                                  fit: BoxFit.cover)),
                          addVerticalSpace(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(eventData().category.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey)),
                              Obx(() => Text('${controller.upvotes} ▲',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey)))
                            ],
                          ),
                          addVerticalSpace(),
                          Text(eventData().title,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500)),
                          Divider(),
                          addVerticalSpace(4),
                          Text(
                            eventData().description,
                          ),
                          addVerticalSpace(20),
                          Text(
                            'Event Information',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          addVerticalSpace(4),
                          Text(
                            'Location: ${eventData().location}',
                          ),
                          addVerticalSpace(4),
                          if (eventData().eventDate != null)
                            Text(
                              'Date: ${formatDate(eventData().eventDate!)}',
                            ),
                          addVerticalSpace(4),
                          if (eventData().members != null &&
                              eventData().totalCapacity != null)
                            Text(
                                'Members: ${eventData().members!.length}/${eventData().totalCapacity}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                          addVerticalSpace(10),
                          
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Obx(() => OutlineButtonMedium(
                                      onPressed: controller.isOwnedEvent.value
                                          ? null
                                          : () {
                                              controller.upvoteEvent();
                                            },
                                      child: controller.isUpvoted.value
                                          ? const Text("Remove Upvote")
                                          : const Text("Upvote"),
                                    )),
                              ),
                            ],
                          ),
                          addVerticalSpace(20),
                          if (controller.isOwnedEvent.value)
                            Row(
                              children: [
                                Expanded(
                                    child: EditButton(controller: controller)),
                                if (!(auth.appUser.value.isAdmin ?? false))
                                  addHorizontalSpace(20),
                                if (!(auth.appUser.value.isAdmin ?? false))
                                  Expanded(child: DeleteButton(event: _event))
                              ],
                            ),
                          addVerticalSpace(20),
                          ChatBox(controller: controller),
                        ],
                      ),
                    ))),
            ),
            showAdminBottomBar(controller, context)
          ],
        ));
  }
}

class MemberBox extends StatelessWidget {
  final profilePictureController = Get.put(ProfilePictureController());
  final _auth = AuthController.instance;
  final controller = Get.put(EventDetailController());
  MemberBox({super.key});
  Event eventData() => controller.eventData.value;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
          // Set desired border radius
          child: SizedBox(
        height: 200, // Set the desired height of the scrollable box
        child: DefaultTabController(
          length: 2, // Number of tabs
          child: Column(
            children: [
              Container(
                color: Colors.white, // Set desired background color
                child: const TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text(
                        'Members',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Join Requests',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Obx(() {
                                return Text(
                                  '${controller.memberList.length}/${eventData().totalCapacity} members joined this event.',
                                  style: const TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }),
                            ),
                            Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.memberList.length,
                                itemBuilder: (context, index) {
                                  return UserRowWidget(
                                      auth: _auth,
                                      profilePictureController:
                                          profilePictureController,
                                      user: controller.memberList[index]);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Obx(() {
                        final requestedUsers = controller.requestedUsers;
                        if (requestedUsers.isEmpty) {
                          return const Text('No requested users');
                        }
                        return ListView.builder(
                          itemCount: requestedUsers.length,
                          itemBuilder: (context, index) {
                            final user = requestedUsers[index];
                            return UserApproveBox(
                                user: user,
                                controller: EventsController.instance,
                                event: controller.eventData.value,
                                requestedUsers: controller.requestedUsers);
                          },
                        );
                      })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class UserRowWidget extends StatelessWidget {
  UserRowWidget(
      {super.key,
      required this.user,
      required AuthController auth,
      required this.profilePictureController})
      : _auth = auth;
  final AppUser user;
  final controller = Get.put(EventDetailController());
  final AuthController _auth;
  final ProfilePictureController profilePictureController;

  // final UserData userData;
  // final auth = AuthController.instance;
  // final controller = Get.put(EventDetailController());

  // UserRowWidget({Key? key, required this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  _auth.appUser.value.profilePicture ??
                      placeholderImageUserPurple,
                  errorBuilder: (context, error, stackTrace) => Image.network(
                    placeholderImageUserPurple,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  // Image size adjustment here
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${user.firstName} ${user.lastName}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              //     minimumSize: MaterialStateProperty.all<Size>(const Size(90, 36)),
              //   ),
              //   onPressed: () {
              //     controller.removeMember(user.uid!);
              //   },
              //   child: const Text('Remove', style: TextStyle(fontSize: 12)),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
    required this.controller,
  });

  final EventDetailController controller;
  @override
  Widget build(BuildContext context) {
    return PrimaryButtonMedium(
        onPressed: () {
          Get.toNamed(Routes.editEvent,
              parameters: {'id': controller.eventData.value.id!});
        },
        child: const Text("Edit Event"));
  }
}

class JoinButton extends StatelessWidget {
  const JoinButton({
    super.key,
    required this.controller,
  });

  final EventDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => PrimaryButtonMedium(
        onPressed: controller.isJoined.value ||
                controller.isRequested.value ||
                controller.isOwnedEvent.value
            ? null
            : () {
                controller.joinEvent();
              },
        child: Text(controller.joinButtonText.value)));
  }
}

Widget showAdminBottomBar(
    EventDetailController controller, BuildContext context) {
  final event = EventsController.instance;
  final auth = AuthController.instance;
  if (auth.appUser.value.isAdmin == true &&
      (controller.eventData.value.isReported == false ||
          controller.eventData.value.isReported == null)) {
    return Container(
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
            Expanded(child: JoinButton(controller: controller)),
            addHorizontalSpace(20),
            Expanded(
              child: DeleteButton(event: event),
            ),
          ],
        ),
      ),
    );
  } else if (auth.appUser.value.isAdmin == true &&
      controller.eventData.value.isReported == true) {
    return Container(
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
            ElevatedButton(
              onPressed: () {
                controller.reportEventDeny();
                Navigator.pop(context, 'Done');
              },
              child: const Text('Deny'),
            ),
            DeleteButton(event: event)
          ],
        ),
      ),
    );
  }
  return Container(
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
          children: [
            Expanded(child: JoinButton(controller: controller)),
          ],
        )),
  );
}

class DeleteButton extends StatelessWidget {
  final controller = Get.find<EventDetailController>();
  DeleteButton({
    super.key,
    required this.event,
  });

  final EventsController event;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmation'),
              content: const Text('Are you sure you want to remove this event?',
                  style: TextStyle(fontWeight: FontWeight.normal)),
              actions: [
                OutlineButtonMedium(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: Text('Cancel'),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    event.deleteEvent(controller.eventData.value);
                    Get.offAllNamed(Routes.allPagesNav);
                  },
                  child: const Text('Remove'),
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
    );
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
                addHorizontalSpace(10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        eventData().title,
                        style: const TextStyle(
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 22),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      addVerticalSpace(5),
                      Text(
                        'Owner: ${eventData().eventOwner.name}',
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      addVerticalSpace(5),
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
    tagsWidgets.add(
      Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: AppThemeData.themedata.colorScheme.primary, width: 0),
              borderRadius: BorderRadius.circular(50),
              color: AppThemeData.themedata.colorScheme.secondary),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            addHorizontalSpace(),
            Text(
              controller.tags[i],
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            addHorizontalSpace()
          ])),
    );
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
