import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/modules/home/controller/create_event_controller.dart';
import 'package:wismod/modules/home/controller/notification_controller.dart';
import 'package:wismod/theme/theme_data.dart';
import 'package:wismod/utils/app_utils.dart';
// import 'package:image_picker_windows/image_picker_windows.dart';

import '../../../theme/global_widgets.dart';

class CreateEventView extends StatelessWidget {
  CreateEventView({super.key});
  final controller = Get.put(CreateEventController());
  final notiController = Get.put(NotificationController());
  final _auth = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Create Event",
                style: Theme.of(context).textTheme.titleMedium)),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                14.0, 0.0, 14.0, 16.0),
                            child: Text(
                              'Your Event\u0027s Name',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                14.0, 0.0, 14.0, 16.0),
                            child: TextFormFeildThemed(
                                hintText: "Event's Name",
                                validator: controller.validateEventName,
                                controller: controller.eventNameController),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                14.0, 0.0, 14.0, 16.0),
                            child: SizedBox(
                              width: Size.infinite.width,
                              // Button Height Change Here
                              height: 250,
                              child: Obx(
                                () => OutlinedButton.icon(
                                  icon: controller.imageUrl.value == ''
                                      ? const Icon(Icons.image_outlined)
                                      : Expanded(
                                          child: Image.network(
                                            controller.imageUrl.value,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                  onPressed: () => controller.uploadImage(),
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
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                            child: Text(
                              'Your Event\u0027s Detail',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          // Change BoxSize (WIP) later
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                14.0, 0.0, 14.0, 16.0),
                            child: TextAreaThemed(
                              validator: controller.validateEventDetail,
                              hintText: "Event's Detail",
                              controller: controller.eventDetailController,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                            child: Text(
                              'Amount of People',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                14.0, 0.0, 14.0, 16.0),
                            child: TextFormFeildThemed(
                              validator: controller.validateEventAmountOfNumber,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              hintText: "2 - 500",
                              controller:
                                  controller.eventAmountOfNumberController,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                            child: Text(
                              'Location of the Event',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                14.0, 0.0, 14.0, 16.0),
                            child: TextFormFeildThemed(
                              validator: controller.validateEventLocation,
                              hintText: "Location",
                              controller: controller.eventLocationController,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                            child: Text(
                              'Date of event',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                14.0, 0.0, 14.0, 16.0),
                            child: SizedBox(
                              width: double.infinity,
                              // Button Height Change Here
                              height: 47,
                              child: OutlinedButton(
                                onPressed: () async {
                                  controller.pickDate(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Colors.black, //Set border color
                                    width: 1, //Set border width
                                  ),
                                ),
                                child: Obx(
                                  () => Text(
                                    '${controller.dateTime.value.day} / ${controller.dateTime.value.month} / ${controller.dateTime.value.year}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                            child: Text(
                              'Category',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 0.0, 14.0, 16.0),
                              child: DropDownCustom(controller: controller)),
                          // Tags (WIP) later
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                            child: Text(
                              'Tags',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                14.0, 0.0, 14.0, 16.0),
                            child: TextFormFeildThemed(
                              hintText: "Add Tags",
                              controller: controller.eventTagsController,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.addTag();
                                  },
                                  icon: Icon(Icons.add,
                                      color: AppThemeData
                                          .themedata.colorScheme.primary)),
                            ),
                          ),
                          Obx(() => createTags(controller)),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(() => ThemedSwitch(
                                    value: controller.isOn.value,
                                    onChanged: controller.toggleSwitch)),
                                Text(
                                  'Allow Automatic Join',
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  tooltip:
                                      'Allows users to join your event automatically without approval!',
                                  icon: const Icon(Icons.info),
                                  color: Colors.yellow[900],
                                )
                              ],
                            ),
                          ),
                          // Button Style later
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                14.0, 0.0, 14.0, 20.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: PrimaryButtonMedium(
                                onPressed: () => [
                                  controller.createEvent(), 
                                  //if(notiController.toggleSwitchNotification == true){
                                  controller.sendPushMessage(controller.eventNameController.text+': '+controller.eventDetailController.text, 'New Event from ' + _auth.appUser.value.getName())
                                  //}
                                ],
                                child: const Text('Create Event'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }
}

class DropDownCustom extends StatelessWidget {
  const DropDownCustom({
    super.key,
    required this.controller,
  });
  final CreateEventController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: DropdownButtonFormField<String>(
        value: controller.selectedCategory.value,
        items: controller.categoryOptions.map((category) {
          return dropdownMenuItemCustom(category);
        }).toList(),
        onChanged: controller.setSelectedCategory,
        style: const TextStyle(
            fontFamily: "Gotham", fontSize: 40, fontWeight: FontWeight.w500),
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(123, 56, 255, 1),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(123, 56, 255, 1),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
        ),
        dropdownColor: Colors.white,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Color.fromRGBO(123, 56, 255, 1),
        ),
        iconSize: 32,
        elevation: 2,
        isExpanded: true,
      ),
    );
  }

  DropdownMenuItem<String> dropdownMenuItemCustom(String category) {
    return DropdownMenuItem(
      value: category,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Center(
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color.fromRGBO(123, 56, 255, 1),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

Widget createTags(CreateEventController controller) {
  final tagsWidgets = <Widget>[];
  for (int i = 0; i < controller.tags.length; i++) {
    tagsWidgets.add(Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: AppThemeData.themedata.colorScheme.primary, width: 0),
            borderRadius: BorderRadius.circular(50),
            color: AppThemeData.themedata.colorScheme.secondary),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            addHorizontalSpace(),
            Text(
              controller.tags[i],
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(30, 30),
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                ),
                child: const Text('x'),
                onPressed: () {
                  controller.removeTag(i);
                })
          ],
        )));
  }
  return Wrap(
    direction: Axis.horizontal,
    spacing: 10,
    runSpacing: 10,
    children: tagsWidgets,
  );
}
