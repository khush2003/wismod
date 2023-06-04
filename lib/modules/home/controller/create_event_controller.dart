import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';
import 'home_controller.dart';

class CreateEventController extends GetxController {
  final imageUrl = ''.obs;
  final tags = <String>[].obs;
  final selectedCategory = 'Other'.obs;
  final dateTime = DateTime.now().obs;
  final isOn = false.obs;
  final isLoading = true.obs;

  final _firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();
  final _auth = AuthController.instance;

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDetailController = TextEditingController();
  final TextEditingController eventAmountOfNumberController =
      TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventTagsController = TextEditingController();

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

  void setSelectedCategory(String? value) {
    selectedCategory(value ?? '');
  }

  toggleSwitch(bool value) {
    isOn(isOn.value == false ? true : false);
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
      errorSnackBar("No image chosen or image corrupted");
      return;
    }
  }

  void pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2099),
    );
    dateTime(date ?? dateTime.value);
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

  bool validateInputs() {
    String? eventNameError = validateEventName(eventNameController.text);
    String? eventDetailError = validateEventDetail(eventDetailController.text);
    String? eventAmountOfNumberError =
        validateEventAmountOfNumber(eventAmountOfNumberController.text);
    String? eventLocationError =
        validateEventLocation(eventLocationController.text);

    if (eventNameError != null ||
        eventDetailError != null ||
        eventAmountOfNumberError != null ||
        eventLocationError != null) {
      return false;
    }
    return true;
  }

  String? validateEventName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an event name';
    }
    return null;
  }

  String? validateEventDetail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter event details';
    }
    return null;
  }

  String? validateEventAmountOfNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount of people';
    }
    int? amount = int.tryParse(value);
    if (amount == null || amount < 2 || amount > 500) {
      return 'Please enter a valid amount of people';
    }
    return null;
  }

  String? validateEventLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an event location';
    }
    return null;
  }

  void createEvent() async {
    if (validateInputs()) {
      try {
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
        /*NotificationService().showNotification(
            title: eventNameController.text.trim(), body: 'Come and join!');*/
        await FirebaseService().addEvent(event, _auth.appUser.value);
        sucessSnackBar('Event was created sucessfully!');
        // EventsController.instance.events.add(event);
        Get.offAllNamed(Routes.allPagesNav);
      } catch (e) {
        errorSnackBar(
            'There was a problem creating the event. Please recheck your values and try again!');
      }
    } else {
      errorSnackBar(
          'Please fill in all the fields correctly to create an event.');
    }
  }

  void sendPushMessage(String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAq4O_glM:APA91bG_b1Bqqc3nU0SnJ39DZRjvGz_DFOEcrYFUOB6GUtTn7k7ML8EIva60g4ucTaBb_wSzR6CGtOmjCj9eqo4fUidkQuDJMGYyQl5n51zGyQ5X-x5BnTo9blRSRja-cEFpzSTHKU2P'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'topic': 'all',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
              'sound': 'default',
            },
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
              'android channel id': 'dbfood'
            },
            'to': '/topics/all',
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
  }
}
