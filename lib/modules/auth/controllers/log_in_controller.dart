import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/utils/app_utils.dart';

class LogInController extends GetxController {
  final isvisible = false.obs;

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
          Get.snackbar(
            "Error!",
            error.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error!",
          "Please enter a password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Please enter a vaild Email without a domain (no @...) or with @kmutt.ac.th",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
