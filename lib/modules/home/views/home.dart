import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar (WIP) later
            const TextField(
              decoration: InputDecoration(
                  labelText: "Search", border: OutlineInputBorder()),
            ),
            addVerticalSpace(20),
            Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 20.0),
              child: SizedBox(
                child: OutlineButtonMedium(
                  onPressed: () => Get.toNamed(Routes.createEvent),
                  child: const Text('Create Event'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
