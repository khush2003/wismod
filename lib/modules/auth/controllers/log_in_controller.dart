import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';

class LogInController extends GetxController {
  final isvisible = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void toogleVisible() {
    isvisible(!isvisible.value);
  }

  Future<void> loginUser() async {
    final emailText = emailController.text.trim();
    final email = emailText.endsWith('@kmutt.ac.th')
        ? emailText.trim()
        : '${emailText.trim()}@kmutt.ac.th';
    final password = passwordController.text;
    String? error = await AuthController.instance
        .loginWithEmailAndPassword(email, password);
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }
}
