import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

class AccountController extends GetxController {
  final departmentOptions = [
    'School of Information Technology',
    'Department of Electrical Engineering',
    'Department of Computer Engineering',
    'Department of Electronic and Telecommunication Engineering',
    'Department of Control System and Instrumentation Engineering',
    'Department of Mechanical Engineering',
    'Department of Civil Engineering',
    'Department of Environmental Engineering',
    'Department of Practical Lead Production Engineering',
    'Department of Tool and Material Engineering',
    'Department of Chemical Engineering',
    'Department of Food Engineering',
    'Department of Biological Engineering',
    'Department of Aquaculture Engineering'
  ].obs;
  final selectedDepartment = 'School of Information Technology'.obs;

  static AccountController get instance => Get.find();
  String firstNameUser = '';
  String lastNameUser = '';
  String yearUser = '';

  
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Name';
    } else if (hasFirstNameAndLastName(value)) {
      return 'Name must have a first name and a last name';
    }
    return null;
  }
  
  bool hasFirstNameAndLastName(String name) {
  List<String> nameParts = name.trim().split(' ');
  return nameParts.length == 2;
}

  String? validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your academic year at KMUTT';
    }
    int? year = int.tryParse(value);
    if (year == null || year == 0) {
      return 'Please enter a valid year';
    }
    if (year > 9) {
      return 'Year cannot be larger than 9';
    }
    return null;
  }

  final TextEditingController firstNameController =
      TextEditingController(text: '');
  final TextEditingController lastNameController =
      TextEditingController(text: '');
  final TextEditingController yearController = TextEditingController(text: '');

  @override
  void onInit() async {
    departmentOptions(await FirebaseService().getDepartments() ?? departmentOptions);
    super.onInit();
  }

}
