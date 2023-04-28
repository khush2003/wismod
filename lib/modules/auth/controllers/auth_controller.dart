import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = _auth.currentUser.obs;
    firebaseUser.bindStream(_auth.userChanges());
  }

  Future<String?> createUser(String email, String password) async {
    try {
      // Authenticate user (Create account)
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // If account created sucessfully then redirect to verify email page
      firebaseUser.value != null
          ? Get.offAllNamed(Routes.verifyemail)
          : Get.offAllNamed(Routes.onboarding);
      Get.snackbar("Sucess", "Account Created Sucessfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } on FirebaseAuthException catch (e) {
      return getAuthErrorMessage(e.code);
    } catch (_) {
      return "An error occured. Please try again later";
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Sucess", "Login Sucessful",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      Get.offAllNamed(Routes.allPagesNav);
    } on FirebaseAuthException catch (e) {
      return getAuthErrorMessage(e.code);
    } catch (_) {
      return "Failure";
    }
    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(Routes.onboarding);
  }

  Future<bool> hasAccount() async {
    return firebaseUser.value != null;
  }

  Future<bool> isEmailVerified() async {
    final user = firebaseUser.value;
    if (user != null) {
      await user.reload();
      return user.emailVerified;
    }
    return false;
  }
}
