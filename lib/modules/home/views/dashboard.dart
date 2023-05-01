import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                          onPressed: () => Get.offNamed(Routes.login),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 38.0),
                            child: Text('Change Profile Picture'),
                          ),
                        ),
                        addVerticalSpace(15)
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
                              style: Theme.of(context).textTheme.displayMedium,
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
                              style: Theme.of(context).textTheme.displayMedium,
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
                                      padding:
                                          const EdgeInsets.fromLTRB(6, 3, 6, 3),
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
                          child: GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      'Requested Activities',
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
                                      padding:
                                          const EdgeInsets.fromLTRB(6, 3, 6, 3),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
