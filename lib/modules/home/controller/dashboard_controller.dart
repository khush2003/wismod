import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

class ProfilePictureController extends GetxController {
  final imageUrl = ''.obs;

  final dateTime = DateTime.now().obs;
  final _firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();
  final _auth = AuthController.instance;

  bool setProfilePicture() {
    bool isPassed = false;
    final firestore = FirebaseService();
    try {
      firestore.updateProfilePicture(
          _auth.firebaseUser.value!.uid, imageUrl.value);
      return !isPassed;
    } catch (e) {
      Get.snackbar("Error",
          "An unknown error occured! Please make sure to login and select a proper image file!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return isPassed;
    }
  }

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
