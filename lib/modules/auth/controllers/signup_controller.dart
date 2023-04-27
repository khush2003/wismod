import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';

class SignUpController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final yearController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final departmentOptions = [
    'Department',
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
  ];

  final selectedDepartment = 'Department'.obs;

  final firstNameError = RxString('');
  final lastNameError = RxString('');
  final yearError = RxString('');
  final emailError = RxString('');
  final passwordError = RxString('');
  final confirmPasswordError = RxString('');

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

  String? validateDropdown(String? value) {
    if (value == null || value.isEmpty || value == 'Department') {
      return 'Please select a department';
    }
    return null;
  }

  String? validateEmail(String? value) {
    final emailPattern =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!value.endsWith('@kmutt.ac.th')) {
      return 'Email must end with @kmutt.ac.th';
    } else if (!emailPattern.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
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
