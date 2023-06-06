import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';
import 'package:wismod/shared/models/user.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseService();
  final appUser = AppUser.empty().obs;

  AppUser get user => appUser.value;

  /// A reactive variable that holds the currently signed-in user
  late Rx<User?> firebaseUser;
  StreamSubscription<AppUser>? userSubscription;

  @override
  void onInit() async {
    super.onInit();

    /// Bind the [firebaseUser] variable to the user changes stream of [_auth]
    firebaseUser = _auth.currentUser.obs;
    if (_auth.currentUser != null) {
      appUser(await _firestore.getUserById(_auth.currentUser!.uid));
    }
    firebaseUser.bindStream(_auth.userChanges());
    await fetchUserStream();
    ever(firebaseUser, _updateUserAuto);
  }

  Future<void> fetchUserStream() async {
    if (_auth.currentUser != null) {
      userSubscription = _firestore
          .getUserStream(_auth.currentUser!.uid)
          .listen((updatedUser) {
        appUser(updatedUser);
        try {
          EventsController.instance.initializeLists();
        } catch (e) {}
      });
    }
  }

  @override
  void onClose() {
    userSubscription
        ?.cancel(); // Cancel the subscription when closing the controller
    super.onClose();
  }

  Future<void> _updateUserAuto(User? u) async {
    if (_auth.currentUser != null) {
      appUser(await _firestore.getUserById(_auth.currentUser!.uid));
    } else {
      appUser(AppUser.empty());
    }
  }

  Future<void> updateToken(String token) async {
    await _firestore.updateToken(token, _auth.currentUser!.uid);
    await updateUser();
  }

  Future<void> updateUser() async {
    if (_auth.currentUser != null) {
      appUser(await _firestore.getUserById(_auth.currentUser!.uid));
    } else {
      appUser(AppUser.empty());
    }
  }

  /// Creates a new user account with the given email and password.
  ///
  /// @param email The email address of the new user.
  /// @param password The password of the new user.
  /// @return A [Future] that resolves to null if the account was created successfully,
  /// or a string containing an error message if an error occurred.
  Future<String?> createUser(
      String email, String password, AppUser user) async {
    try {
      // Authenticate user (Create account)
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final confirmedUser = AppUser(
          uid: _auth.currentUser!.uid,
          firstName: user.firstName,
          lastName: user.lastName,
          department: user.department,
          year: user.year,
          blockedChatGroups: [],
          bookmarkedEvents: [],
          joinedEvents: [],
          ownedEvents: [],
          requestedEvents: [],
          upvotedEvents: []);
      _firestore.addUser(confirmedUser);
      appUser(confirmedUser);
      Get.offAllNamed(Routes.allPagesNav);
      sucessSnackBar("Account Created Sucessfully!");
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
      final user = await _firestore.getUserById(_auth.currentUser!.uid);
      if (user != null) {
        appUser(user);
      } else {
        throw Exception();
      }
      Get.offAllNamed(Routes.allPagesNav);
      sucessSnackBar("Login Sucess!");
    } on FirebaseAuthException catch (e) {
      return getAuthErrorMessage(e.code);
    } catch (_) {
      return "There was an unexpected error! Please try again later";
    }
    return null;
  }

  /// Logs out the current user.
  ///
  /// @return A [Future] that resolves when the user is logged out.
  Future<void> logout() async {
    await _auth.signOut();
    appUser(AppUser.empty());
    Get.offAllNamed(Routes.onboarding);
  }

  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
    sucessSnackBar("Email verification sent!");
  }

  /// Checks whether there is a currently signed-in user
  Future<bool> hasAccount() async {
    return _auth.currentUser != null;
  }
}
