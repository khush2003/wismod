import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_windows/image_picker_windows.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventView();
}

class _CreateEventView extends State<CreateEventView> {
  File? image;

  Future pickImage() async {
    // ImagePicker For Phone
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    // ImagePicker For Windows
    /*final image =
        await ImagePickerWindows().pickImage(source: ImageSource.gallery);*/

    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDetailController = TextEditingController();
  final TextEditingController eventAmountOfNumberController =
      TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventTagsController = TextEditingController();

  DateTime dateTime = DateTime(2023, 1, 1);

  bool autoJoin = true;

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
                    hintText: "Event's Name", controller: eventNameController),
              ),
              // Image Picker (WIP)
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: SizedBox(
                  width: double.infinity,
                  // Button Height Change Here
                  height: 250,
                  child: OutlinedButton.icon(
                    icon: image != null
                        ? Image.file(
                            image!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_outlined),
                    //icon: const Icon(Icons.image_outlined),
                    onPressed: () => pickImage(),
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
                child: TextFormFeildThemed(
                  hintText: "Event's Detail",
                  controller: eventDetailController,
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
                  hintText: "2 - 500",
                  controller: eventAmountOfNumberController,
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
                  controller: eventLocationController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Date',
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
                      final date = await pickDate();
                      if (date == null) return;

                      setState(() => dateTime = date);
                    },
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.black, //Set border color
                        width: 1, //Set border width
                      ),
                    ),
                    child: Text(
                      '${dateTime.day} / ${dateTime.month} / ${dateTime.year}',
                      style: Theme.of(context).textTheme.displayLarge,
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
                  controller: eventTagsController,
                ),
              ),
              // AutoJoin Switch (WIP)later
              // Custom Switch?
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildSwitch(),
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
                    onPressed: () => Get.toNamed(Routes.home),
                    /*style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                color: Colors.black, //Set border color
                                width: 1, //Set border width
                              )),*/
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

  Widget buildSwitch() => Switch.adaptive(
        value: autoJoin,
        onChanged: (autoJoin) => setState(() => this.autoJoin = autoJoin),
      );

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2023),
        lastDate: DateTime(2099),
      );
}
