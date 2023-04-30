import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/home_controller.dart';
import 'package:wismod/modules/home/views/filter_options.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final homeController = Get.put(HomeController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(sideWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBox(th: th),
                addHorizontalSpace(20),
                IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      // TODO: Change to Get.toNamed() and create Route
                      Get.to(
                        FilterOptionsView(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    icon: const Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.black,
                      size: 35,
                    ))
              ],
            ),
            addVerticalSpace(20),
            SizedBox(
              child: OutlineButtonMedium(
                onPressed: () => Get.toNamed(Routes.createEvent),
                child: const Text('Create Event'),
              ),
            ),
            addVerticalSpace(),
            PrimaryButtonMedium(
                child: const Text("Log Out (Checking)"),
                onPressed: () => homeController.logOut())
          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key, required this.th});
  final ThemeData th;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
            suffixIcon: const Icon(Icons.search_rounded),
            suffixIconColor: th.colorScheme.primary,
            hintText: "Search",
            hintStyle: TextStyle(
                fontFamily: "Gotham",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: th.colorScheme.primary),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: th.colorScheme.primary)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: th.colorScheme.primary))),
        maxLines: 1,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
