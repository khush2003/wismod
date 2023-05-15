import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/modules/home/controller/all_pages_nav_controller.dart';
import 'package:wismod/routes/routes.dart';
import 'package:wismod/utils/app_utils.dart';

class PasswordController extends GetxController {
  var auth = FirebaseAuth.instance;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();

  final passwordError = RxString('');
  final confirmPasswordError = RxString('');


  changePassword() async {
    final currentPassword = currentPasswordController.text;
    final newPassword = passwordController.text;
    var currentUser = FirebaseAuth.instance.currentUser;
    final email = AuthController.instance.firebaseUser.value!.email!;
    var cred =
        EmailAuthProvider.credential(email: email, password: currentPassword);
    if (validateInputs()) {
      try {
        await currentUser!.reauthenticateWithCredential(cred);
        currentUser.updatePassword(newPassword);
        Get.back();
        sucessSnackBar("Your password has been changed");
      } catch (error) {
        errorSnackBar(
            "Your current password doesn't match with current password that you've typed");
      }
    } else {
      errorSnackBar(
          'Please fill in all the fields correctly to change your password');
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
      return false;
    }
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
