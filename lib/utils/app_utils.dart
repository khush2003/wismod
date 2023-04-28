import 'package:flutter/material.dart';

const double sideWidth = 20;

SizedBox addVerticalSpace([double gap = 10]) {
  return SizedBox(height: gap);
}

SizedBox addHorizontalSpace([double gap = 10]) {
  return SizedBox(width: gap);
}

bool checkEmail(String email){
  final emailPattern = RegExp(r'^\w+@kmutt\.ac\.th$');
  return emailPattern.hasMatch(email);
}

String getCorrectEmail(String email){
  final emailPattern = RegExp(r'^\w+@kmutt\.ac\.th$');
  if (emailPattern.hasMatch(email)) {
    return email;
  } else {
    return '$email@kmutt.ac.th';
  }
}

