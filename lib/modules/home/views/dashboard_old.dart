import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:wismod/modules/home/controller/dashboard_controller.dart';

import '../../../theme/global_widgets.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});
  final profilePictureController = Get.put(ProfilePictureController());
  final dropDownController = Get.put(DropDownController());
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
                            '${auth.appUser.value.firstName} ${auth.appUser.value.lastName}',
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
                                '16 activities',
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
                                '12 Upvotes',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF4F4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              height: 50,
                              child: Obx(() => DropdownButton(
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  itemHeight: null,
                                  icon: null,
                                  iconSize: 0.0,
                                  value: dropDownController.dropdownState
                                      .upcomingSelectedValue.value,
                                  items: dropDownController
                                      .dropdownState.upcomingDropdownItems,
                                  onChanged: (newValue) {
                                    dropDownController.dropdownState
                                        .onItemSelectedUpcoming(newValue!);
                                  })),
                            ),
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF4F4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              height: 50,
                              child: Obx(() => DropdownButton(
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    itemHeight: null,
                                    icon: null,
                                    iconSize: 0.0,
                                    value: dropDownController.dropdownState
                                        .requestedSelectedValue.value,
                                    items: dropDownController
                                        .dropdownState.requestedDropdownItems,
                                    onChanged: (newValue) {
                                      dropDownController.dropdownState
                                          .onItemSelectedRequested(newValue!);
                                    },
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF4F4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              height: 50,
                              child: Obx(() => DropdownButton(
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    itemHeight: null,
                                    icon: null,
                                    iconSize: 0.0,
                                    value: dropDownController.dropdownState
                                        .bookmarkedSelectedValue.value,
                                    items: dropDownController
                                        .dropdownState.bookmarkedDropdownItems,
                                    onChanged: (newValue) {
                                      dropDownController.dropdownState
                                          .onItemSelectedBookmarked(newValue!);
                                    },
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF4F4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              height: 50,
                              child: Obx(() => DropdownButton(
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    itemHeight: null,
                                    icon: null,
                                    iconSize: 0.0,
                                    value: dropDownController
                                        .dropdownState.ownSelectedValue.value,
                                    items: dropDownController
                                        .dropdownState.ownDropdownItems,
                                    onChanged: (newValue) {
                                      dropDownController.dropdownState
                                          .onItemSelectedOwn(newValue!);
                                    },
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
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
