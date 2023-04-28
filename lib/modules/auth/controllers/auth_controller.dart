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
      if (firebaseUser.value != null) {
        await sendEmailVerification();
        Get.offAllNamed(Routes.verifyemail);
      } else {
        Get.offAllNamed(Routes.onboarding);
      }
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
      if (!_auth.currentUser!.emailVerified) {
        Get.offAllNamed(Routes.verifyemail);
      } else {
        Get.offAllNamed(Routes.allPagesNav);
      }
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

  Future<void> sendEmailVerification() async {
    await firebaseUser.value?.sendEmailVerification();
    Get.snackbar("Sucess", "Email Verification Sent! Please Check your Email",
        backgroundColor: Colors.green, colorText: Colors.white);
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

  Future<void> checkEmailVerified() async {
    firebaseUser.refresh();
    await firebaseUser.value?.reload();
    if (firebaseUser.value != null && firebaseUser.value!.emailVerified) {
      Get.offAllNamed(Routes.allPagesNav);
    }
    Get.snackbar("Incomplete!", "Email has not yet been verified!",
        snackPosition: SnackPosition.BOTTOM);
  }
}
