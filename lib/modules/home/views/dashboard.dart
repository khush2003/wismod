import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';
import 'package:wismod/shared/models/user.dart';
import 'package:wismod/theme/theme_data.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:wismod/modules/home/controller/dashboard_controller.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';
import '../../../shared/models/event.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});
  final profilePictureController = Get.put(ProfilePictureController());
  final fourButtonsController = Get.put(FourButtonsController());
  final _auth = AuthController.instance;
  var _event = EventsController.instance;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      body: Obx(
        () => fourButtonsController.isLoading.value
            ? const LoadingWidget()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFEAF4F4),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            addVerticalSpace(24),
                            const Text('Profile',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Color.fromRGBO(123, 56, 255, 1),
                                    fontWeight: FontWeight.bold)),
                            addVerticalSpace(16),
                            CircleAvatar(
                              radius: 90,
                              backgroundImage: Image.network(
                                      _auth.appUser.value.profilePicture ??
                                          placeholderImage,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.network(
                                                placeholderImage,
                                                fit: BoxFit.cover,
                                              ),
                                      fit: BoxFit.cover)
                                  .image,
                            ),
                            addVerticalSpace(20),
                            Column(
                              children: [
                                Text(
                                  _auth.appUser.value.getName(),
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                addVerticalSpace(),
                                Text(
                                  _auth.appUser.value.department,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                addVerticalSpace(),
                                Text(
                                  'Year ${_auth.appUser.value.year}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                addVerticalSpace(),
                                OutlineButtonMedium(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Choose Profile Picture"),
                                          content: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                14.0, 0.0, 14.0, 16.0),
                                            child: SizedBox(
                                              width: double.infinity,
                                              // Button Height Change Here
                                              height: 250,
                                              child: Obx(
                                                () => OutlinedButton.icon(
                                                  icon: profilePictureController
                                                              .imageUrl.value ==
                                                          ''
                                                      ? const Icon(
                                                          Icons.image_outlined)
                                                      : Image.network(
                                                          profilePictureController
                                                              .imageUrl.value,
                                                          fit: BoxFit.cover,
                                                        ),
                                                  onPressed: () =>
                                                      profilePictureController
                                                          .uploadImage(),
                                                  label: const Text(''),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    side: const BorderSide(
                                                      color: Colors
                                                          .black, //Set border color
                                                      width:
                                                          1, //Set border width
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            OutlineButtonMedium(
                                                child: const Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                            SecondaryButtonMedium(
                                              child: const Text("Save"),
                                              onPressed: () {
                                                profilePictureController
                                                    .setProfilePicture();
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 38.0),
                                    child: Text('Change Profile Picture'),
                                    // color: Color(0xFFEAF4F4),
                                    // borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                addVerticalSpace(20),
                              ],
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(sideWidth),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Dashboard',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          addVerticalSpace(),
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceEvenly,
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(123, 56, 255, 1),
                                    width: 2.0,
                                  ),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Joined Events',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    addVerticalSpace(),
                                    Text(
                                      '${_event.joinedEvents.length} Events',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(123, 56, 255, 1),
                                    width: 2.0,
                                  ),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Upvoted Events',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                    addVerticalSpace(),
                                    Text(
                                      '${_event.upvotedEvents.length} Upvotes',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          addVerticalSpace(20),
                          Column(
                            children: [
                              FourButtonsWidget(
                                activityType: 'Joined Events',
                                activityNumber: _event.joinedEvents.length,
                                onPressed: fourButtonsController.toggleJoined,
                                showSizeBox: fourButtonsController.showJoined,
                              ),
                              Obx(() => fourButtonsController.showJoined.value
                                  ? SizedBox(
                                      height: 230,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          color: Color(0xffEAF4F4),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: _event.joinedEvents.isNotEmpty
                                            ? ListView.builder(
                                                itemCount:
                                                    _event.joinedEvents.length,
                                                itemBuilder: (context, index) {
                                                  final event = _event
                                                      .joinedEvents[index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          Routes.eventDetials,
                                                          parameters: {
                                                            'id': event.id!
                                                          });
                                                    },
                                                    child: OtherActivityBox(
                                                      event: event,
                                                    ),
                                                  );
                                                },
                                              )
                                            : const EmptyEventsList(),
                                      ),
                                    )
                                  : const SizedBox()),
                              addVerticalSpace(16),
                              FourButtonsWidget(
                                activityType: 'Join Requests',
                                activityNumber:
                                    _event.getTotaLengthJoinRequests(),
                                onPressed:
                                    fourButtonsController.toggleRequested,
                                showSizeBox:
                                    fourButtonsController.showRequested,
                              ),
                              Obx(() => fourButtonsController
                                      .showRequested.value
                                  ? SizedBox(
                                      height: 230,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          color: Color(0xffEAF4F4),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Obx(() => ListView.builder(
                                              itemCount: _event
                                                  .allEventJoinRequests.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final event = _event
                                                    .allEventJoinRequests.keys
                                                    .toList()[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.toNamed(
                                                            Routes.eventDetials,
                                                            arguments: {
                                                              'id': event.id
                                                            },
                                                          );
                                                        },
                                                        child:
                                                            _requestedActivityBox(
                                                                index, _event),
                                                      ),
                                                      addVerticalSpace(),
                                                    ],
                                                  ),
                                                );
                                              },
                                            )),
                                      ),
                                    )
                                  : const SizedBox()),
                              addVerticalSpace(16),
                              FourButtonsWidget(
                                activityType: 'Bookmarked Events',
                                activityNumber: _event.bookmarkedEvents.length,
                                onPressed: () {
                                  Get.bottomSheet(BookMarkList(
                                      fourButtonsController:
                                          fourButtonsController,
                                      event: _event));
                                },
                                showSizeBox:
                                    fourButtonsController.showBookmarked,
                              ),
                              addVerticalSpace(16),
                              FourButtonsWidget(
                                activityType: 'Events You Own',
                                activityNumber: _event.ownedEvents.length,
                                onPressed: fourButtonsController.toggleOwn,
                                showSizeBox: fourButtonsController.showOwn,
                              ),
                              Obx(() => fourButtonsController.showOwn.value
                                  ? SizedBox(
                                      height: 230,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          color: Color(0xffEAF4F4),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: _event.ownedEvents.isNotEmpty
                                            ? ListView.builder(
                                                itemCount:
                                                    _event.ownedEvents.length,
                                                itemBuilder: (context, index) {
                                                  final event =
                                                      _event.ownedEvents[index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          Routes.eventDetials,
                                                          parameters: {
                                                            'id': event.id!
                                                          });
                                                    },
                                                    child: OtherActivityBox(
                                                      event: event,
                                                    ),
                                                  );
                                                },
                                              )
                                            : const EmptyEventsList(),
                                      ),
                                    )
                                  : const SizedBox()),
                              addVerticalSpace(16),
                              FourButtonsWidget(
                                activityType: 'Archived Events',
                                activityNumber: _event.archivedEvents.length,
                                onPressed: () => Get.bottomSheet(
                                  ArchivedList(event: _event),
                                ),
                                showSizeBox: fourButtonsController.showArchived,
                              ),
                              addVerticalSpace(16),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    ));
  }
}

class ArchivedList extends StatelessWidget {
  const ArchivedList({
    super.key,
    required EventsController event,
  }) : _event = event;

  final EventsController _event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Size.infinite.height,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color(0xffEAF4F4),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: _event.archivedEvents.isNotEmpty
            ? ListView.builder(
                itemCount: _event.archivedEvents.length,
                itemBuilder: (context, index) {
                  final event = _event.archivedEvents[index];
                  return OtherActivityBox(
                    event: event,
                  );
                },
              )
            : const EmptyEventsList(),
      ),
    );
  }
}

class BookMarkList extends StatelessWidget {
  const BookMarkList({
    super.key,
    required this.fourButtonsController,
    required EventsController event,
  }) : _event = event;

  final FourButtonsController fourButtonsController;
  final EventsController _event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 230,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color(0xffEAF4F4),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: _event.bookmarkedEvents.isNotEmpty
              ? ListView.builder(
                  itemCount: _event.bookmarkedEvents.length,
                  itemBuilder: (context, index) {
                    final event = _event.bookmarkedEvents[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.eventDetials,
                            parameters: {'id': event.id!});
                      },
                      child: OtherActivityBox(
                        event: event,
                      ),
                    );
                  },
                )
              : const EmptyEventsList(),
        ));
  }
}

class EmptyEventsList extends StatelessWidget {
  const EmptyEventsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(top: 107.0),
          child: Center(
            child: Text(
              'You do not have any Events.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }
}

class FourButtonsWidget extends StatelessWidget {
  final String activityType;
  final int activityNumber;
  final VoidCallback onPressed;
  final fourButtonsController = Get.put(FourButtonsController());
  final RxBool showSizeBox;
  FourButtonsWidget({
    Key? key,
    required this.activityType,
    required this.activityNumber,
    required this.onPressed,
    required this.showSizeBox,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
      color: const Color(0xFFEAF4F4),
      borderRadius: showSizeBox.value
          ? const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )
          : BorderRadius.circular(10),
    );

    return InkWell(
      onTap: onPressed,
      child: Obx(() => Container(
            decoration: boxDecoration.copyWith(
              borderRadius: showSizeBox.value
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                  : BorderRadius.circular(10),
              boxShadow: [
                !showSizeBox.value
                    ? BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(
                            0, 3), // changes the position of the shadow
                      )
                    : const BoxShadow(),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    activityType,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7B38FF),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF669F),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                    child: Text(
                      activityNumber.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Icon(
                  showSizeBox.value
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                  size: 40,
                  color: const Color(0xFF7B38FF),
                ),
              ],
            ),
          )),
    );
  }
}

class OtherActivityBox extends StatelessWidget {
  final Event event;
  const OtherActivityBox({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFFF669F),
              offset: Offset(0, 4),
              blurRadius: 3,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(sideWidth),
          child: Column(
            children: [
              addVerticalSpace(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDate(event.eventDate!),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF669F),
                    ),
                  ),
                ],
              ),
              addVerticalSpace(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.title.length <= 20
                        ? event.title
                        : '${event.title.substring(0, 20)}...',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              addVerticalSpace(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.location.length <= 30
                        ? event.location
                        : '${event.location.substring(0, 30)}...',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFFFF669F),
                    ),
                  ),
                ],
              ),
              addVerticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category: ${event.category}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF669F),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: Not updating ui when denying a join request

Widget _requestedActivityBox(int index, EventsController controller) {
  final event = controller.allEventJoinRequests.keys.elementAt(index);
  final users = controller.allEventJoinRequests.values.elementAt(index);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        width: Size.infinite.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFFF669F),
              offset: Offset(0, 4),
              blurRadius: 3,
            ),
          ],
        ),
        child: Text(
          'Event: ${event.title}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      addVerticalSpace(20),
      SizedBox(
        height: 250,
        child: Obx(() => ListView.separated(
            separatorBuilder: (context, index) => addVerticalSpace(),
            itemCount:
                controller.allEventJoinRequests.values.elementAt(index).length,
            itemBuilder: (context, index) => UserApproveBox(
                  user: users[index],
                  controller: controller,
                  event: event,
                ))),
      ),
    ],
  );
}

class UserApproveBox extends StatelessWidget {
  final EventsController controller;
  final AppUser user;
  final Event event;
  const UserApproveBox({
    super.key,
    required this.user,
    required this.controller,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFFF669F),
            offset: Offset(0, 4),
            blurRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(sideWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Request from: ${user.getName()}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            addVerticalSpace(),
            Text(
              'Department: ${user.department}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            addVerticalSpace(),
            Row(
              children: [
                Text(
                  'Year: ${user.year}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            addVerticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                addHorizontalSpace(15),
                OutlineButtonMedium(
                  onPressed: () {
                    controller.approveJoin(user, event);
                  },
                  child: const Text('Approve'),
                ),
                SecondaryButtonMedium(
                  onPressed: () {
                    controller.denyJoin(user, event);
                  },
                  child: const Text('Deny'),
                ),
                addHorizontalSpace(15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
