import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AccountController extends GetxController {
  static AccountController get instance => Get.find();
  String firstNameUser = '';
  String lastNameUser = '';
  String yearUser = '';

  final TextEditingController firstNameController =
      TextEditingController(text: '');
  final TextEditingController lastNameController =
      TextEditingController(text: '');
  final TextEditingController yearController = TextEditingController(text: '');
}
