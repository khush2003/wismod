import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/utils/app_utils.dart';
import '../../auth/controllers/auth_controller.dart';

class AccountController extends GetxController {
  final departmentOptions = [
    '',
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

  // late RxString selectedDepartment = departmentFromDB.obs;
  final selectedDepartment = ''.obs;

  final _auth = AuthController.instance;
  final FirebaseAuth authBase = FirebaseAuth.instance;
  final _fireBase = FirebaseFirestore.instance;

  static AccountController get instance => Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    departmentOptions(
        await FirebaseService().getDepartments() ?? departmentOptions);
    initializeValues();
  }

  void initializeValues() {
    nameController.text = _auth.appUser.value.getName();
    yearController.text = _auth.appUser.value.year.toString();
    selectedDepartment(_auth.appUser.value.department);
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Name';
    } else if (!hasFirstNameAndLastName(value)) {
      return 'Name must have a first name and a last name';
    } else {}
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

  // For future use
  @override
  void onClose() {
    nameController.dispose();
    yearController.dispose();
    super.onClose();
  }

  nameIsTheSame(String newFirstname, newLastname) {
    late String oldFirstname = _auth.appUser.value.firstName;
    late String oldLasttname = _auth.appUser.value.lastName;
    if (newFirstname == oldFirstname && newLastname == oldLasttname) {
      return true;
    } else {
      return false;
    }
  }

  validYearCheck(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    int? year = int.tryParse(value);
    if (year == null || year == 0) {
      return false;
    }
    if (year > 9) {
      return false;
    }
    return true;
  }

  yearIsTheSame(int newYear) {
    late int preYear = _auth.appUser.value.year;
    if (newYear == preYear) {
      return true;
    }
    return false;
  }

  Future<void> updateName() async {
    final List<String> splitedName = nameController.text.trim().split(' ');

    if (splitedName.length == 2) {
      final String firstName = splitedName[0];
      final String lastName = splitedName[1];
      if (nameIsTheSame(firstName, lastName) == false) {
        try {
          final User? user = authBase.currentUser;
          final uid = user?.uid;
          await _fireBase
              .collection("Users")
              .doc(uid)
              .update({'Firstname': firstName});

          await _fireBase
              .collection("Users")
              .doc(uid)
              .update({'Lastname': lastName});
          sucessSnackBar('Your first name and last name has been changed');
          authBase.currentUser!.reload();
        } catch (e) {
          if (kDebugMode) {
            print('Error updating name: $e');
          }
        }
      } else {
        errorSnackBar(
            "You can't change your new name that's the same with your old name");
      }
    } else {
      errorSnackBar(
          'Please fill in all the fields correctly to change your First name and Last name');
    }
  }

  Future<void> updateYear() async {
    String yearCheck = yearController.text;
    if (validYearCheck(yearCheck)) {
      int? year = int.tryParse(yearCheck);
      if (yearIsTheSame(year!) == false) {
        try {
          final User? user = authBase.currentUser;
          final uid = user?.uid;
          await _fireBase.collection("Users").doc(uid).update({'Year': year});

          sucessSnackBar('Your year has been changed');
          authBase.currentUser!.reload();
        } catch (e) {
          if (kDebugMode) {
            print('Error updating year: $e');
          }
        }
      } else {
        errorSnackBar(
            "You can't fill new year that's the same with the old one");
      }
    } else {
      errorSnackBar('Please fill correct year');
    }
  }

  departmentIsSame(String newDepartment) {
    String oldDepartment = _auth.appUser.value.department;
    // ignore: unrelated_type_equality_checks
    if (oldDepartment == newDepartment) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateDepartment() async {
    String choosenDepartment = selectedDepartment.value;
    if (departmentIsSame(choosenDepartment) == false) {
      try {
        final User? user = authBase.currentUser;
        final uid = user?.uid;
        await _fireBase
            .collection("Users")
            .doc(uid)
            .update({'Department': choosenDepartment});

        sucessSnackBar('Your department has been changed');
        authBase.currentUser!.reload();
      } catch (e) {
        if (kDebugMode) {
          print('Error updating department: $e');
        }
      }
    } else {
      errorSnackBar(
          "You can't choose new department that's the same with the old one");
    }
  }
}
