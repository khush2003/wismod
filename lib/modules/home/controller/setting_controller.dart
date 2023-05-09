import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/shared/models/user.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';

class SettingController extends GetxController {
  late BuildContext? context;
  var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  int checkCount = 0;
  String wordCheck = "";

  final passwordError = RxString('');
  final confirmPasswordError = RxString('');

  check() {
    checkCount = checkCount + 1;
  }

  changePassword({email, currentPassword, newPassword}) async {
    var cred =
        EmailAuthProvider.credential(email: email, password: currentPassword);
    if (validateInputs()) {
      String? error =
          await currentUser!.reauthenticateWithCredential(cred).then((value) {
        currentUser!.updatePassword(newPassword);
        Get.snackbar(
          'Sucess',
          "Your password has been changed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        currentUser!.reload();
        currentUser = FirebaseAuth.instance.currentUser;
        print("Password changed");
        if (currentUser == null) {
          print("Hey, you're null");
        }
        check();
      }).catchError((error) {
        print(error);
        Get.snackbar(
          'Error',
          "Your current password doesn't match with current password that you've typed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 10),
        );
      });
      if (error != null) {
        Get.snackbar('Error', error.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 10),
            colorText: Colors.white);
      }
    } else {
      Get.snackbar(
        'Error',
        'Please fill in all the fields correctly to change your password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 10),
      );
    }
  }

  bool validateInputs() {
    String? passwordError = validatePassword(passwordController.text);
    String? confirmPasswordError =
        validateConfirmPassword(confirmPasswordController.text);

    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        passwordError != null ||
        confirmPasswordError != null) {
      print("you didn't type it all");
      print(passwordController.text);
      print(confirmPasswordController.text);
      return false;
    }
    print("you type it all");
    return true;
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
