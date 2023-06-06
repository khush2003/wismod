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
  final _event = EventsController.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => fourButtonsController.isLoading.value
            ? const LoadingWidget()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileSection(
                        auth: _auth,
                        profilePictureController: profilePictureController),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: sideWidth),
                      child: Column(
                        children: [
                          OverviewSection(event: _event),
                          addVerticalSpace(20),
                          Column(
                            children: [
                              ExpandingEvents(
                                activityType: 'Joined Events',
                                activityNumber: _event.joinedEvents.length,
                                onPressed: () => Get.bottomSheet(
                                  DisplayList(eventList: _event.joinedEvents),
                                  isScrollControlled: true,
                                ),
                              ),
                              addVerticalSpace(16),
                              ExpandingEvents(
                                  activityType: 'Join Requests',
                                  activityNumber:
                                      _event.getTotaLengthJoinRequests(),
                                  onPressed: () => Get.bottomSheet(
                                      RequestList(event: _event),
                                      isScrollControlled: true)),
                              addVerticalSpace(16),
                              ExpandingEvents(
                                activityType: 'Bookmarked Events',
                                activityNumber: _event.bookmarkedEvents.length,
                                onPressed: () {
                                  Get.bottomSheet(
                                      DisplayList(
                                          eventList: _event.bookmarkedEvents),
                                      isScrollControlled: true);
                                },
                              ),
                              addVerticalSpace(16),
                              ExpandingEvents(
                                activityType: 'Events You Own',
                                activityNumber: _event.ownedEvents.length,
                                onPressed: () => Get.bottomSheet(
                                    DisplayList(eventList: _event.ownedEvents),
                                    isScrollControlled: true),
                              ),
                              addVerticalSpace(16),
                              ExpandingEvents(
                                activityType: 'Archived Events',
                                activityNumber: _event.archivedEvents.length,
                                onPressed: () => Get.bottomSheet(
                                  DisplayList(
                                      eventList: _event.archivedEvents,
                                      isClickable: false),
                                  isScrollControlled: true,
                                ),
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
    );
  }
}

class RequestList extends StatelessWidget {
  const RequestList({
    super.key,
    required EventsController event,
  }) : _event = event;

  final EventsController _event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            Flexible(
              child: Obx(() => _event.allEventJoinRequests.isNotEmpty
                  ? Obx(() => ListView.builder(
                        itemCount: _event.allEventJoinRequests.length,
                        itemBuilder: (BuildContext context, int index) {
                          final event =
                              _event.allEventJoinRequests.keys.elementAt(index);
                          List<AppUser> users =
                              _event.allEventJoinRequests[event]!;
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                _requestedActivityBox(index, event, users),
                                addVerticalSpace()
                              ],
                            ),
                          );
                        },
                      ))
                  : const EmptyEventsList(
                      message:
                          'No join requests found for any event you own!')),
            ),
          ])),
    );
  }
}

class OverviewSection extends StatelessWidget {
  const OverviewSection({
    super.key,
    required EventsController event,
  }) : _event = event;

  final EventsController _event;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${_event.joinedEvents.length} ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              addVerticalSpace(2),
              Text(
                'Joined Events',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${_event.upvotedEvents.length} ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              addVerticalSpace(2),
              Text(
                'Upvoted Events',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required AuthController auth,
    required this.profilePictureController,
  }) : _auth = auth;

  final AuthController _auth;
  final ProfilePictureController profilePictureController;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      addVerticalSpace(24),
      const Text('DASHBOARD',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold)),
      addVerticalSpace(16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 200,
              width: 200,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(200)),
              child: ClipRRect(
                borderRadius: BorderRadiusDirectional.circular(500),
                child: Obx(() => Image.network(
                   profilePictureController.profilePictureDisplay.value ?? 
                        placeholderImageUserPurple,
                    errorBuilder: (context, error, stackTrace) => Image.network(
                          placeholderImageUserPurple,
                          fit: BoxFit.fill,
                        ),
                    fit: BoxFit.fill)),
              )),
        ],
      ),
      addVerticalSpace(20),
      Column(
        children: [
          Text(
            _auth.appUser.value.getName(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          addVerticalSpace(),
          Text(
            _auth.appUser.value.department,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          addVerticalSpace(),
          Text(
            'Year ${_auth.appUser.value.year}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          addVerticalSpace(),
          OutlineButtonMedium(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Choose Profile Picture"),
                    content: Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        // Button Height Change Here
                        height: 250,
                        child: Obx(
                          () => OutlinedButton.icon(
                            icon: profilePictureController.imageUrl.value == ''
                                ? const Icon(Icons.image_outlined)
                                : Expanded(
                                    child: Image.network(
                                      profilePictureController.imageUrl.value,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                            onPressed: () =>
                                profilePictureController.uploadImage(),
                            label: const Text(''),
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.black, //Set border color
                                width: 1, //Set border width
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
                          profilePictureController.setProfilePicture();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 38.0),
              child: Text('Change Profile Picture'),
              // color: Color(0xFFEAF4F4),
              // borderRadius: BorderRadius.circular(10),
            ),
          ),
          addVerticalSpace(20),
        ],
      ),
    ]);
  }
}

class DisplayList extends StatelessWidget {
  final bool isClickable;
  const DisplayList({
    super.key,
    required this.eventList,
    this.isClickable = true,
  });
  final RxList<Event> eventList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            eventList.isNotEmpty
                ? Flexible(
                    child: ListView.builder(
                      itemCount: eventList.length,
                      itemBuilder: (context, index) {
                        final event = eventList[index];
                        return GestureDetector(
                          onTap: () {
                            if (isClickable) {
                              Get.toNamed(Routes.eventDetials,
                                  parameters: {'id': event.id!});
                            }
                          },
                          child: SizedBox(
                            height: 210,
                            child: OtherActivityBox(
                              event: event,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const EmptyEventsList(),
          ])),
    );
  }
}

class EmptyEventsList extends StatelessWidget {
  final String message;
  const EmptyEventsList(
      {Key? key, this.message = 'No events found for this list'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 107.0),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class ExpandingEvents extends StatelessWidget {
  final String activityType;
  final int activityNumber;
  final VoidCallback onPressed;
  final fourButtonsController = Get.put(FourButtonsController());
  ExpandingEvents({
    Key? key,
    required this.activityType,
    required this.activityNumber,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
      color: primary,
      borderRadius: BorderRadius.circular(10),
    );
    return InkWell(
        onTap: onPressed,
        child: Container(
          decoration: boxDecoration.copyWith(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  activityType,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF669F),
                        borderRadius: BorderRadius.circular(500),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
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
                    addHorizontalSpace(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
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
        padding: const EdgeInsets.all(sideWidth),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            addVerticalSpace(16),
            Flexible(
              child: Text(
                event.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            addVerticalSpace(16),
            Flexible(
              child: Text(
                event.location,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
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
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _requestedActivityBox(int index, Event event, List<AppUser> users) {
  final controller = EventsController.instance;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(18),
        width: Size.infinite.width,
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Event: ${event.title}',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      addVerticalSpace(20),
      Column(
          children: users
              .map((u) => UserApproveBox(
                    user: u,
                    controller: controller,
                    event: event,
                  ))
              .toList())
    ],
  );
}

class UserApproveBox extends StatelessWidget {
  final EventsController controller;
  final AppUser user;
  final Event event;
  final RxList<AppUser>? requestedUsers;
  const UserApproveBox({
    super.key,
    required this.user,
    required this.controller,
    required this.event,
    this.requestedUsers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(20),
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
                  color: Colors.white),
            ),
            addVerticalSpace(),
            Text(
              'Department: ${user.department}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
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
                      color: Colors.white),
                ),
              ],
            ),
            addVerticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                addHorizontalSpace(15),
                PrimaryButtonMedium(
                  color: Colors.green,
                  onPressed: () {
                    controller.approveJoin(user, event);
                    requestedUsers?.remove(user);
                  },
                  child: const Text('Approve'),
                ),
                SecondaryButtonMedium(
                  onPressed: () {
                    controller.denyJoin(user, event);
                    requestedUsers?.remove(user);
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
