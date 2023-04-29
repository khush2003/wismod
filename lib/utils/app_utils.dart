import 'package:flutter/material.dart';

const double sideWidth = 20;

/// Returns a SizedBox widget with a specified height [gap].
/// By default, [gap] is set to 10.
SizedBox addVerticalSpace([double gap = 10]) {
  return SizedBox(height: gap);
}

/// Returns a SizedBox widget with a specified width [gap].
/// By default, [gap] is set to 10.
SizedBox addHorizontalSpace([double gap = 10]) {
  return SizedBox(width: gap);
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
