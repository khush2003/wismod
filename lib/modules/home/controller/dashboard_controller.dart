import 'dart:developer';

import 'package:get/get.dart';
import 'package:wismod/utils/app_utils.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

import 'events_controller.dart';

class ProfilePictureController extends GetxController {
  final imageUrl = ''.obs;
  final Rx<String?> profilePictureDisplay = ''.obs;
  final dateTime = DateTime.now().obs;
  final _firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();
  final _auth = AuthController.instance;

  @override
  void onReady() {
    profilePictureDisplay(_auth.appUser.value.profilePicture);
    ever(_auth.appUser, (appUser) {
      profilePictureDisplay(appUser.profilePicture);
    });
    super.onReady();
  }

  Future<bool> setProfilePicture() async {
    bool isPassed = false;
    final firestore = FirebaseService();
    try {
      await firestore.updateProfilePicture(
          _auth.firebaseUser.value!.uid, imageUrl.value);
      profilePictureDisplay(imageUrl.value);
      return !isPassed;
    } catch (e) {
      errorSnackBar(
          "An unknown error occured! Please make sure to login and select a proper image file!");
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
      errorSnackBar("No image chosen or image corrupted");
      return;
    }
  }
}

class FourButtonsController extends GetxController {
  var showJoined = false.obs;
  var showRequested = false.obs;
  var showBookmarked = false.obs;
  var showOwn = false.obs;
  final showArchived = false.obs;

  final firestore = FirebaseService();
  final _event = EventsController.instance;
  final isLoading = true.obs;
  final auth = AuthController.instance;

  @override
  void onInit() {
    super.onInit();
    _initialize(); //Wait till you get all the data from database (Using this )
  }

  Future<void> _initialize() async {
    ever(_event.isInitialized, (isInitialized) {
      if (isInitialized) {
        isLoading(false);
      }
    });
  }

  void toggleJoined() {
    showJoined(!showJoined.value);
  }

  void toggleArchived() {
    showArchived(!showArchived.value);
  }

  void toggleRequested() {
    showRequested(!showRequested.value);
  }

  void toggleBookmarked() {
    showBookmarked(!showBookmarked.value);
  }

  void toggleOwn() {
    showOwn(!showOwn.value);
  }
}
