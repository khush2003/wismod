import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:wismod/modules/home/controller/dashboard_controller.dart';

import '../../../theme/global_widgets.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});
  final profilePictureController = Get.put(ProfilePictureController());
  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // String dropdownValue = 'Upcoming Activities';

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
                      addVerticalSpace(),
                      const CircleAvatar(
                        radius: 90,
                        backgroundImage: NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1671581559476-10b8a92ffb77?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
                        ),
                      ),
                      addVerticalSpace(20),
                      Column(
                        children: [
                          Text(
                            'Khush Agarwal',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          addVerticalSpace(),
                          Text(
                            'Computer Science',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          addVerticalSpace(),
                          Text(
                            'Year 1',
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
                            child: GestureDetector(
                              onTap: () {},
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        'Upcoming Activities',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF669F),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            6, 3, 6, 3),
                                        child: Text(
                                          '2',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
                                    ),
                                    addHorizontalSpace(),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      size: 40,
                                    )
                                  ],
                                ),
                              ),
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
                              child: DropdownButton(
                                isExpanded: true,
                                value: 'Requested Activities',
                                onChanged: (dynamic newValue) {},
                                underline: const SizedBox(),
                                itemHeight: null,
                                icon: null,
                                iconSize: 0.0,
                                items: [
                                  DropdownMenuItem(
                                    value: 'Requested Activities',
                                    child: SizedBox(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SizedBox(
                                          height: 40,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  'Requested Activities',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  '2',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 40,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Activity 1',
                                    child: SizedBox(
                                      height: 240,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: _buildActivityBox(
                                            'KMUTT BioHackathon'),
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Activity 2',
                                    child: SizedBox(
                                      height: 240,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: _buildActivityBox(
                                            'Boxing Hackathon'),
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Activity 3',
                                    child: SizedBox(
                                      height: 240,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: _buildActivityBox(
                                            'Robotic Hackathon'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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

Widget _buildActivityBox(String activityName) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 2),
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
            children: const [
              Text(
                '20/04/2023',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
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
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          addVerticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Request from: Jane Vive',
                style: TextStyle(
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
