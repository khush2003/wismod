import 'package:flutter/material.dart';

const double sideWidth = 20;

SizedBox addVerticalSpace([double gap = 10]) {
  return SizedBox(height: gap);
}

SizedBox addHorizontalSpace([double gap = 10]) {
  return SizedBox(width: gap);
}

bool checkEmail(String input) {
  RegExp regex =
      RegExp(r'^[a-zA-Z0-9._%+-]+(@kmutt\.ac\.th)?$', caseSensitive: false);
  return regex.hasMatch(input);
}

String getCorrectEmail(String input) {
  if (!input.contains('@')) {
    return '$input@kmutt.ac.th';
  } else {
    return input;
  }
}
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