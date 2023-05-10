import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

import '../../../routes/routes.dart';

class CreateEventController extends GetxController {
  final imageUrl = ''.obs;
  final tags = <String>[].obs;
  final selectedCategory = 'Other'.obs;

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDetailController = TextEditingController();
  final TextEditingController eventAmountOfNumberController =
      TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventTagsController = TextEditingController();

  final dateTime = DateTime.now().obs;
  final _firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();
  final _auth = AuthController.instance;
  final isOn = false.obs;
  final isLoading = true.obs;

  void setSelectedCategory(String? value) {
    selectedCategory(value ?? '');
  }

  late List<String> categoryOptions;

  @override
  void onInit() async {
    isLoading(true);
    categoryOptions = await FirebaseService().getCategories() ??
        [
          'Default',
          'Competition',
          'Tutoring',
          'Sports',
          'Hanging Out',
          'Thesis'
              'Other',
        ];
    categoryOptions.remove('Default');
    isLoading(false);
    super.onInit();
  }

  toggleSwitch(bool value) {
    isOn(isOn.value == false ? true : false);
  }

  void addTag() {
    final tag = '#${eventTagsController.text.trim()}';
    if (!tags.contains(tag)) {
      tags.add(tag);
    } else {
      Get.snackbar('Warning', 'Tag with same name already exists',
          backgroundColor: Colors.yellow, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void removeTag(int index) {
    tags.removeAt(index);
  }

  //TODO: Add more validaiton functions
  String? validateTotalCapacity(int? value) {
    if (value == null || value <= 2 || value >= 500) {
      return 'Please enter a vaild amount of people';
    }
    return null;
  }

  uploadImage() async {
    //Select Image
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var file = File(image.path);
      //Upload to Firebase
      var snapshot = await _firebaseStorage
          .ref()
          .child('images/${image.name}')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrl(downloadUrl);
    } else {
      Get.snackbar("Error!", "No image chosen or image corrupted");
      return;
    }
  }

  void pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: dateTime.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2099),
    );
    dateTime(date ?? dateTime.value);
  }

  void createEvent() async {
    // try {
    final eventOwner = _auth.appUser.value;
    final event = Event(
      createdAt: DateTime.now(),
      description: eventDetailController.text.trim(),
      eventDate: dateTime.value,
      imageUrl: imageUrl.value,
      members: [],
      tags: tags,
      totalCapacity: int.parse(eventAmountOfNumberController.text.trim()),
      location: eventLocationController.text.trim(),
      category: selectedCategory.value,
      title: eventNameController.text.trim(),
      upvotes: 0,
      allowAutomaticJoin: isOn.value,
      eventOwner: EventOwner(
          name: eventOwner.getName(),
          department: eventOwner.department,
          year: eventOwner.year,
          uid: eventOwner.uid!),
    );
    await FirebaseService().addEvent(event, _auth.appUser.value);
    Get.snackbar('Sucess', 'Event was created sucessfulyy!',
        backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
    Get.offAllNamed(Routes.allPagesNav);
    // } catch (e) {
    //   print(e);
    //   Get.snackbar('Error',
    //       'There was a problem creating the event. Please recheck your values and try again!',
    //       backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    // }
  }
}
