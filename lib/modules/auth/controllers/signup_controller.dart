import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/shared/models/user.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

import '../../../utils/app_utils.dart';
import 'auth_controller.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final yearController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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

  @override
  void onInit() async {
    super.onInit();
    departmentOptions(
        await FirebaseService().getDepartments() ?? departmentOptions);
  }

  Future<void>? registerUser() async {
    final email = getCorrectEmail(emailController.text.trim());
    final password = passwordController.text;
    if (validateInputs()) {
      final user = AppUser(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          department: selectedDepartment.value,
          year: int.parse(yearController.text));
      String? error = await _auth.createUser(email, password, user);
      if (error != null) {
        errorSnackBar(error.toString());
      }
    } else {
      errorSnackBar(
          'Please fill in all the fields correctly to create an account.');
    }
  }

  final _auth = AuthController.instance;

  bool validateInputs() {
    String? firstNameError = validateFirstName(firstNameController.text);
    String? lastNameError = validateLastName(lastNameController.text);
    String? yearError = validateYear(yearController.text);
    String? emailError = validateEmail(emailController.text);
    String? passwordError = validatePassword(passwordController.text);
    String? confirmPasswordError =
        validateConfirmPassword(confirmPasswordController.text);

    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        yearController.text.isEmpty ||
        selectedDepartment.value == 'Department' ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        firstNameError != null ||
        lastNameError != null ||
        yearError != null ||
        emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      return false;
    }

    return true;
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    } else if (value.length > 20) {
      return 'First name cannot be longer than 20 characters';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    } else if (value.length > 20) {
      return 'Last name cannot be longer than 20 characters';
    }
    return null;
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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return checkEmail(emailController.text.trim())
        ? null
        : "Please enter a vaild email";
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
