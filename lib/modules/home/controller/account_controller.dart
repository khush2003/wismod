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

  late String departmentFromDB = _auth.appUser.value.getDepartment();

  // late RxString selectedDepartment = departmentFromDB.obs;
  late RxString selectedDepartment = 'Department of Computer Engineering'.obs;

  final _auth = AuthController.instance;
  final FirebaseAuth authBase = FirebaseAuth.instance;
  final _fireBase = FirebaseFirestore.instance;

  static AccountController get instance => Get.find();
  String firstNameUser = '';
  String lastNameUser = '';
  String yearUser = '';

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

  @override
  void onInit() async {
    super.onInit();
    departmentOptions(
        await FirebaseService().getDepartments() ?? departmentOptions);
  }
  // For future use
  // @override
  // void onClose() {
  //   // You can perform any cleanup here
  //   firstNameController.dispose();
  //   // lastNameController.dispose();
  //   yearController.dispose();
  //   super.onClose();
  // }

  // Same name with old one check (experimental)

  late String preFirstname = _auth.appUser.value.getFirstname();
  late String preLastname = _auth.appUser.value.getLastname();
  late int preYear = _auth.appUser.value.year;

  // ignore: non_constant_identifier_names
  late String prefirstname_lastname = "$preFirstname $preLastname";

  late TextEditingController nameController =
      TextEditingController(text: prefirstname_lastname);
  late TextEditingController yearController =
      TextEditingController(text: preYear.toString());

  nameIsTheSame(String newFirstname, newLastname) {
    late String oldFirstname = _auth.appUser.value.getFirstname();
    late String oldLasttname = _auth.appUser.value.getLastname();
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
            print('Error updating name: $e');
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
}
