import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(sideWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/IconWisMod.png',
                  height: 90,
                  fit: BoxFit.fill,
                  color: const Color.fromRGBO(123, 56, 255, 1),
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'WISMOD',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Gotham",
                              fontWeight: FontWeight.bold,
                              fontSize: 72,
                              color: Color.fromRGBO(123, 56, 255, 1)),
                        ),
                        addVerticalSpace(2),
                        const Text(
                          'Work like mods',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Gotham",
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButtonMedium(
                    onPressed: () => Get.toNamed(Routes.login),
                    child: const Text('Log In'),
                  ),
                ),
                addVerticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Don't have an account? ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, fontFamily: "Gotham"),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.signup);
                          },
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              fontFamily: 'Gotham',
                              decoration: TextDecoration.underline,
                              color: Color.fromRGBO(123, 56, 255, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
