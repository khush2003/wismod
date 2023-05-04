import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

import '../../../theme/global_widgets.dart';
import '../../../utils/app_utils.dart';

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

class DropDownController extends GetxController {
  final dropdownState = DropdownState();
}

class DropdownState {
  RxString upcomingSelectedValue = 'Upcoming Activities'.obs;
  RxString requestedSelectedValue = 'Requested Activities'.obs;
  RxString bookmarkedSelectedValue = 'Bookmarked Activities'.obs;
  RxString ownSelectedValue = 'Activities You Own'.obs;
  RxBool isOpen = false.obs;
  List<DropdownMenuItem<String>> upcomingDropdownItems = [
    DropdownMenuItem(
      value: 'Upcoming Activities',
      child: SizedBox(
        //height: 40,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Upcoming Activities',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B38FF),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF669F),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                  child: Text(
                    '2',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                size: 40,
                color: Color(0xFF7B38FF),
              ),
            ],
          ),
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Activity 1',
      child: SizedBox(
        height: 225,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _otherActivityBox('KMUTT BioHackathon'),
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Activity 2',
      child: SizedBox(
        height: 225,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _otherActivityBox('Boxing Hackathon'),
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Activity 3',
      child: SizedBox(
        height: 225,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _otherActivityBox('Robotic Hackathon'),
        ),
      ),
    ),
  ];
  List<DropdownMenuItem<String>> requestedDropdownItems = [
    DropdownMenuItem(
      value: 'Requested Activities',
      child: SizedBox(
        //height: 40,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Requested Activities',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B38FF),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF669F),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                  child: Text(
                    '2',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                size: 40,
                color: Color(0xFF7B38FF),
              ),
            ],
          ),
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Activity 1',
      child: SizedBox(
        height: 235,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _requestedActivityBox('KMUTT BioHackathon'),
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Activity 2',
      child: SizedBox(
        height: 240,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _requestedActivityBox('Boxing Hackathon'),
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Activity 3',
      child: SizedBox(
        height: 240,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _requestedActivityBox('Robotic Hackathon'),
        ),
      ),
    ),
  ];
  List<DropdownMenuItem<String>> bookmarkedDropdownItems = [
    DropdownMenuItem(
      value: 'Bookmarked Activities',
      child: SizedBox(
        //height: 40,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Bookmarked Activities',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B38FF),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF669F),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                  child: Text(
                    '2',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                size: 40,
                color: Color(0xFF7B38FF),
              ),
            ],
          ),
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Activity 1',
      child: SizedBox(
        height: 210,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _otherActivityBox('KMUTT BioHackathon'),
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Activity 2',
      child: SizedBox(
        height: 210,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _otherActivityBox('Boxing Hackathon'),
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Activity 3',
      child: SizedBox(
        height: 210,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _otherActivityBox('Robotic Hackathon'),
        ),
      ),
    ),
  ];
  List<DropdownMenuItem<String>> ownDropdownItems = [
    DropdownMenuItem(
      value: 'Activities You Own',
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Activities You Own',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B38FF),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFF669F),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                child: Text(
                  '2',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              size: 40,
              color: Color(0xFF7B38FF),
            ),
          ],
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Activity 1',
      child: SizedBox(
        height: 210,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _otherActivityBox('KMUTT BioHackathon'),
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Activity 2',
      child: SizedBox(
        height: 210,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _otherActivityBox('Boxing Hackathon'),
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Activity 3',
      child: SizedBox(
        height: 210,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _otherActivityBox('Robotic Hackathon'),
        ),
      ),
    ),
  ];

  void onItemSelectedUpcoming(String newValue) {
    upcomingSelectedValue.value = newValue;
  }

  void onItemSelectedRequested(String newValue) {
    requestedSelectedValue.value = newValue;
  }

  void onItemSelectedBookmarked(String newValue) {
    bookmarkedSelectedValue.value = newValue;
  }

  void onItemSelectedOwn(String newValue) {
    ownSelectedValue.value = newValue;
  }
}

Widget _requestedActivityBox(String activityName) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: const [
        BoxShadow(
          color: Color(0xFFFF669F),
          offset: Offset(0, 4),
          blurRadius: 3,
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(sideWidth),
      child: Column(
        children: [
          addVerticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '20/04/2023',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF669F),
                ),
              ),
            ],
          ),
          addVerticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                activityName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          addVerticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Request from: Jane Vive',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFFFF669F),
                ),
              ),
            ],
          ),
          addVerticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              addHorizontalSpace(15),
              OutlineButtonMedium(
                onPressed: () {},
                child: const Text('Approve'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF33D81), // Red
                  foregroundColor: Colors.white, // Text color
                ),
                child: const Text('Deny'),
              ),
              addHorizontalSpace(15),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _otherActivityBox(String activityName) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: const [
        BoxShadow(
          color: Color(0xFFFF669F),
          offset: Offset(0, 4),
          blurRadius: 3,
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(sideWidth),
      child: Column(
        children: [
          addVerticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '20/04/2023',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF669F),
                ),
              ),
            ],
          ),
          addVerticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                activityName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          addVerticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "SIT's Playground",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFFFF669F),
                ),
              ),
            ],
          ),
          addVerticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Category: Competition',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF669F),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
