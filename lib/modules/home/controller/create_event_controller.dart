import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class CreateEventController extends GetxController {
  final imageUrl = ''.obs;

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDetailController = TextEditingController();
  final TextEditingController eventAmountOfNumberController =
      TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventTagsController = TextEditingController();

  final dateTime = DateTime.now().obs;
  final _firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();

  uploadImage() async {
    //Check Permissions
    //Select Image
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var file = File(image.path);
      //Upload to Firebase
      var snapshot =
          await _firebaseStorage.ref().child('images/imageName').putFile(file);
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

  void createEvent() {
    // TODO: Implement this function to create an event
  }
}
