import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/shared/models/user.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';

class SettingController extends GetxController {
  // var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  changePassword({email, currentPassword, newPassword}) async {
    var cred =
        EmailAuthProvider.credential(email: email, password: currentPassword);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
