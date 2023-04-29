import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// A reactive variable that holds the currently signed-in user
  late Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();

    /// Bind the [firebaseUser] variable to the user changes stream of [_auth]
    firebaseUser = _auth.currentUser.obs;
    firebaseUser.bindStream(_auth.userChanges());
  }

  /// Creates a new user account with the given email and password.
  ///
  /// @param email The email address of the new user.
  /// @param password The password of the new user.
  /// @return A [Future] that resolves to null if the account was created successfully,
  /// or a string containing an error message if an error occurred.
  Future<String?> createUser(String email, String password) async {
    try {
      // Authenticate user (Create account)
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.offAllNamed(Routes.allPagesNav);
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

  /// Signs in a user with the given [email] and [password]
  ///
  /// @param email The email address of the existing user.
  /// @param password The password of the existing user.
  /// @return A [Future] that resolves to null if the login was successful,
  /// or a string containing an error message if an error occurred.
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

  /// Logs out the current user.
  ///
  /// @return A [Future] that resolves when the user is logged out.
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(Routes.onboarding);
  }

  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
    Get.snackbar("Sucess", "Email Verification Sent! Please Check your Email",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  /// Checks whether there is a currently signed-in user
  Future<bool> hasAccount() async {
    return _auth.currentUser != null;
  }
}
