import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/shared/models/user.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:wismod/shared/models/user.dart';
import '../../auth/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../routes/routes.dart';

class AccountController extends GetxController {
  static AccountController get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String firstNameUser = '';
  String lastNameUser = '';
  String yearUser = '';

  final TextEditingController firstNameController =
      TextEditingController(text: 'Test1');
  final TextEditingController lastNameController =
      TextEditingController(text: 'Test2');
  final TextEditingController yearController =
      TextEditingController(text: 'Test3');
}
