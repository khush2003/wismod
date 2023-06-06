import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/utils/app_utils.dart';

class LogInController extends GetxController {
  final isvisible = false.obs;

  bool buttonclicked = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = AuthController.instance;
  void toogleVisible() {
    isvisible(!isvisible.value);
  }

  Future<void> loginUser() async {
    bool vaildEmail = checkEmail(emailController.text.trim());
    if (vaildEmail) {
      if (passwordController.text != "") {
        final email = getCorrectEmail(emailController.text.trim());
        final password = passwordController.text;
        String? error = await _auth.loginWithEmailAndPassword(email, password);
        if (error != null) {
          errorSnackBar(error.toString());
        }
      } else {
        errorSnackBar("Please enter a passsword!");
      }
    } else {
      errorSnackBar(
          "Please enter a vaild Email without a domain (no @...) or with @kmutt.ac.th");
    }
  }

  Future<void> sendMail() async {
    bool vaildEmail = checkEmail(emailController.text.trim());
    if (vaildEmail) {
      final email = getCorrectEmail(emailController.text.trim());
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        buttonclicked = true;
      } catch (error) {
        errorSnackBar(error.toString());
      }
    } else {
      errorSnackBar(
          "Please enter a vaild Email without a domain (no @...) or with @kmutt.ac.th");
    }
  }

  isButtonClicked() {
    if (buttonclicked == true) {
      return true;
    } else {
      return false;
    }
  }
}
