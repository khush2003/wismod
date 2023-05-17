import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double sideWidth = 20;

/// Returns a SizedBox widget with a specified height [gap].
/// By default, [gap] is set to 8.
SizedBox addVerticalSpace([double gap = 8]) {
  return SizedBox(height: gap);
}

void sucessSnackBar(String message) {
  Get.snackbar("Sucess", message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: Colors.green);
}

void errorSnackBar(String message) {
  Get.snackbar("Error", message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: Colors.red);
}

const placeholderImage =
    'https://perspectives.agf.com/wp-content/plugins/accelerated-mobile-pages/images/SD-default-image.png';

const placeholderImageEvent = 'https://imgur.com/AHyN72z.png';

const placeholderImageEventButE = 'https://i.imgur.com/xZ79vFv.png';

const placeholderImageUser = 'https://i.imgur.com/cM8lKpP.png';

const placeholderImageUserPurple = 'https://imgur.com/jcVOD5C.png';

/// Returns a SizedBox widget with a specified width [gap].
/// By default, [gap] is set to 8.
SizedBox addHorizontalSpace([double gap = 8]) {
  return SizedBox(width: gap);
}

const chatboxWidthRatio = 0.7;
String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);

  if (dateTime.isAfter(today)) {
    return 'Today at ${_formatTime(dateTime)}';
  } else if (dateTime.isAfter(yesterday)) {
    return 'Yesterday at ${_formatTime(dateTime)}';
  } else {
    return '${_formatDate(dateTime)} ${_formatTime(dateTime)}';
  }
}

String _formatDate(DateTime dateTime) {
  return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
}

String _formatTime(DateTime dateTime) {
  return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

String formatDate(DateTime date) {
  String month;
  switch (date.month) {
    case 1:
      month = 'January';
      break;
    case 2:
      month = 'February';
      break;
    case 3:
      month = 'March';
      break;
    case 4:
      month = 'April';
      break;
    case 5:
      month = 'May';
      break;
    case 6:
      month = 'June';
      break;
    case 7:
      month = 'July';
      break;
    case 8:
      month = 'August';
      break;
    case 9:
      month = 'September';
      break;
    case 10:
      month = 'October';
      break;
    case 11:
      month = 'November';
      break;
    case 12:
      month = 'December';
      break;
    default:
      month = 'January';
      break;
  }
  String formattedDate =
      "${date.day.toString().padLeft(2, '0')}-$month-${date.year}";
  return formattedDate;
}

/// Checks if a given email [input] is valid (is ending with @kmutt.ac.th or does not have a @....).
/// Returns a boolean indicating whether the email is valid or not.
bool checkEmail(String input) {
  RegExp regex =
      RegExp(r'^[a-zA-Z0-9._%+-]+(@kmutt\.ac\.th)?$', caseSensitive: false);
  return regex.hasMatch(input);
}

/// Returns the correct email address by appending '@kmutt.ac.th'
/// Does not check if email is correct (for that use checkEmail method)
/// if the input email [input] does not already contain '@'.
/// Otherwise, it returns the input email as is.
String getCorrectEmail(String input) {
  if (!input.contains('@')) {
    return '$input@kmutt.ac.th';
  } else {
    return input;
  }
}

/// Returns an error message corresponding to the given [errorCode].
/// This function is specifically designed to handle Firebase authentication errors.
String getAuthErrorMessage(String errorCode) {
  switch (errorCode) {
    // Sign in errors
    case "invalid-email":
      return "Invalid email address. Please check your input and try again.";
    case "wrong-password":
      return "Incorrect password. Please try again.";
    case "user-not-found":
      return "This email address is not associated with an account. Please sign up first.";
    case "user-disabled":
      return "This account has been disabled. Please contact support for assistance.";
    case "too-many-requests":
      return "Too many requests. Please try again later.";
    case "operation-not-allowed":
      return "This operation is not allowed. Please try again later.";
    case "weak-password":
      return "Your password is too weak. Please choose a stronger password.";
    // Sign up errors
    case "email-already-in-use":
      return "This email address is already in use. Please sign in or use a different email address.";
    case "invalid-credential":
      return "Invalid credentials. Please check your input and try again.";
    case "invalid-verification-code":
      return "Invalid verification code. Please check your input and try again.";
    case "invalid-verification-id":
      return "Invalid verification ID. Please check your input and try again.";
    case "phone-number-already-exists":
      return "This phone number is already in use. Please sign in or use a different phone number.";
    case "quota-exceeded":
      return "Quota exceeded. Please try again later.";
    case "provider-already-linked":
      return "This provider is already linked to this account. Please sign in or use a different provider.";
    default:
      return "An unknown error occurred. Please try again later.";
  }
}
