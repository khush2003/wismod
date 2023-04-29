import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/create_event_controller.dart';
// import 'package:image_picker_windows/image_picker_windows.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';
import '../controller/all_pages_nav_controller.dart';

class CreateEventView extends StatelessWidget {
  CreateEventView({super.key});
  final createViewController = Get.put(CreateEventController());
  final themedSwitch = ThemedSwitch();
  // To get the value of the switch use themedSwitch.getSwitchValue()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Create Event",
              style: Theme.of(context).textTheme.titleMedium)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: Text(
                  'Your Event\u0027s Name',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: TextFormFeildThemed(
                    hintText: "Event's Name",
                    controller: createViewController.eventNameController),
              ),
              // Image Picker (WIP)
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: SizedBox(
                  width: double.infinity,
                  // Button Height Change Here
                  height: 250,
                  child: Obx(
                    () => OutlinedButton.icon(
                      icon: createViewController.imageUrl.value == ''
                          ? const Icon(Icons.image_outlined)
                          : Image.network(
                              createViewController.imageUrl.value,
                              fit: BoxFit.cover,
                            ),
                      onPressed: () => createViewController.uploadImage(),
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
              //SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Your Event\u0027s Detail',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              // Change BoxSize (WIP) later
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: TextAreaThemed(
                  hintText: "Event's Detail",
                  controller: createViewController.eventDetailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Amount of People',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: TextFormFeildThemed(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  hintText: "2 - 500",
                  controller:
                      createViewController.eventAmountOfNumberController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Location of the Event',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: TextFormFeildThemed(
                  hintText: "Location",
                  controller: createViewController.eventLocationController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Date of event',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: SizedBox(
                  width: double.infinity,
                  // Button Height Change Here
                  height: 47,
                  child: OutlinedButton(
                    onPressed: () async {
                      createViewController.pickDate(context);
                    },
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.black, //Set border color
                        width: 1, //Set border width
                      ),
                    ),
                    child: Obx(
                      () => Text(
                        '${createViewController.dateTime.value.day} / ${createViewController.dateTime.value.month} / ${createViewController.dateTime.value.year}',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ),
                ),
              ),
              // Category (WIP) later
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 47,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.black, //Set border color
                        width: 1, //Set border width
                      ),
                    ),
                    child: const Text(
                      'Category',
                    ),
                  ),
                ),
              ),
              // Tags (WIP) later
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Tags',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: TextFormFeildThemed(
                  hintText: "Add a Tags",
                  controller: createViewController.eventTagsController,
                ),
              ),
              // AutoJoin Switch (WIP)later
              // Custom Switch?
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    themedSwitch,
                    Text(
                      'Allow Automatic Join',
                      style: Theme.of(context).textTheme.displayLarge,
                    )
                  ],
                ),
              ),
              // Create Event Button (Algo) later
              // Button Style later
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: PrimaryButtonMedium(
                    onPressed: () => Get.offAllNamed(Routes.allPagesNav,
                        arguments: {'page': Pages.homePage}),
                    child: const Text('Create Event'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
