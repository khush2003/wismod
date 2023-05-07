import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:wismod/modules/home/controller/dashboard_controller.dart';
import 'package:intl/intl.dart';

import '../../../theme/global_widgets.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});
  final profilePictureController = Get.put(ProfilePictureController());
  final fourButtonsController = Get.put(FourButtonsController());
  final auth = AuthController.instance;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: SingleChildScrollView(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
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
                          auth.appUser.value.profilePicture ?? placeholderImage,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.network(
                            placeholderImage,
                            fit: BoxFit.cover,
                          ),
                        ).image,
                      ),
                      addVerticalSpace(20),
                      Column(
                        children: [
                          Text(
                            auth.appUser.value.getName(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          addVerticalSpace(),
                          Text(
                            auth.appUser.value.department,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          addVerticalSpace(),
                          Text(
                            'Year ${auth.appUser.value.year}',
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
                                    title: const Text("Choose Profile Picture"),
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
                                            style: ElevatedButton.styleFrom(
                                              side: const BorderSide(
                                                color: Colors
                                                    .black, //Set border color
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
                    ]),
                  ],
                ),
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
                              color: const Color.fromRGBO(123, 56, 255, 1),
                              width: 2.0,
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Joined Activities',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              addVerticalSpace(),
                              Text(
                                '${auth.appUser.value.joinedEvents!.length} Activities',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromRGBO(123, 56, 255, 1),
                              width: 2.0,
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Upvote Activities',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              addVerticalSpace(),
                              Text(
                                '${auth.appUser.value.upvotedEvents!.length} Upvotes',
                                style: Theme.of(context).textTheme.bodyMedium,
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
                          activityType: 'Upcoming Activities',
                          activityNumber: 1,
                          onPressed: fourButtonsController.toggleUpcoming,
                          showSizeBox: fourButtonsController.showUpcoming,
                        ),
                        Obx(() => fourButtonsController.showUpcoming.value
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
                                  child: ListView.builder(
                                    itemCount: 3,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          children: [
                                            _otherActivityBox(
                                              activityDate: DateTime.now(),
                                              activityName:
                                                  'My Activity $index',
                                              activityLocation:
                                                  'My Location $index',
                                              activityCategory:
                                                  'My Category $index',
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox()),
                        addVerticalSpace(16),
                        FourButtonsWidget(
                          activityType: 'Requested Activities',
                          activityNumber: 1,
                          onPressed: fourButtonsController.toggleRequested,
                          showSizeBox: fourButtonsController.showRequested,
                        ),
                        Obx(() => fourButtonsController.showRequested.value
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
                                  child: ListView.builder(
                                    itemCount: 3,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          children: [
                                            _requestedActivityBox(
                                                'Activity Name',
                                                DateTime.now(),
                                                'Jane Vive'),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox()),
                        addVerticalSpace(16),
                        FourButtonsWidget(
                          activityType: 'Bookmarked Activities',
                          activityNumber: 1,
                          onPressed: fourButtonsController.toggleBookmarked,
                          showSizeBox: fourButtonsController.showBookmarked,
                        ),
                        Obx(() => fourButtonsController.showBookmarked.value
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
                                  child: ListView.builder(
                                    itemCount: 3,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          children: [
                                            _otherActivityBox(
                                              activityDate: DateTime.now(),
                                              activityName:
                                                  'My Activity $index',
                                              activityLocation:
                                                  'My Location $index',
                                              activityCategory:
                                                  'My Category $index',
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox()),
                        addVerticalSpace(),
                        FourButtonsWidget(
                          activityType: 'Activities You Own',
                          activityNumber: 1,
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
                                  child: ListView.builder(
                                    itemCount: 3,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          children: [
                                            _otherActivityBox(
                                              activityDate: DateTime.now(),
                                              activityName:
                                                  'My Activity $index',
                                              activityLocation:
                                                  'My Location $index',
                                              activityCategory:
                                                  'My Category $index',
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox()),
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

Widget _otherActivityBox(
    {required DateTime activityDate,
    required String activityName,
    required String activityLocation,
    required String activityCategory}) {
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
        children: [
          addVerticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat("dd/MM/yyyy").format(activityDate),
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
                activityName,
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
                activityLocation,
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
                'Category: $activityCategory',
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
  );
}

Widget _requestedActivityBox(
    String activityName, DateTime activityDate, String requestMember) {
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
        children: [
          addVerticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat("dd/MM/yyyy").format(activityDate),
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
                activityName,
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
                'Request from: $requestMember',
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
              addHorizontalSpace(15),
              OutlineButtonMedium(
                onPressed: () {},
                child: const Text('Approve'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF33D81), // Red
                  foregroundColor: Colors.white, // Text color
                ),
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
