import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureController extends GetxController {
  final imageUrl = ''.obs;

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
}

class FourButtonsController extends GetxController {
  var showUpcoming = false.obs;
  var showRequested = false.obs;
  var showBookmarked = false.obs;
  var showOwn = false.obs;

  void toggleUpcoming() {
    showUpcoming.value = !showUpcoming.value;
  }

  void toggleRequested() {
    showRequested.value = !showRequested.value;
  }

  void toggleBookmarked() {
    showBookmarked.value = !showBookmarked.value;
  }

  void toggleOwn() {
    showOwn.value = !showOwn.value;
  }
}
