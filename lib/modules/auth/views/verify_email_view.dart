import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/utils/app_utils.dart';

import '../controllers/verify_email_controller.dart';

class VerifyEmailView extends StatelessWidget {
  VerifyEmailView({super.key});
  final authController = AuthController.instance;
  final verifyEmailController = Get.put(VerifyEmailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Verify Email")),
        body: Padding(
          padding: const EdgeInsets.all(sideWidth),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    "Email verification sent to ${authController.firebaseUser.value?.email}",
                    style: Theme.of(context).textTheme.displayLarge),
                Text("Please verify your email to complete registeration!",
                    style: Theme.of(context).textTheme.displayLarge),
                PrimaryButtonMedium(
                    child: const Text("ReSend Email Verification"),
                    onPressed: () {
                      verifyEmailController.canResend
                          ? authController.sendEmailVerification()
                          : null;
                    }),
                SecondaryButtonMedium(
                    child: const Text("SignOut"),
                    onPressed: () {
                      authController.logout();
                    }),
                OutlineButtonMedium(
                    child: const Text("Check Email verified"),
                    onPressed: () {
                      authController.checkEmailVerified();
                    }),
              ],
            ),
          ),
        ));
  }
}
