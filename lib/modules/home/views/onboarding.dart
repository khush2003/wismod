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
            Image.asset(
              'assets/images/WisModLonger.png',
              height: 175,
              fit: BoxFit.fill,
            ),
            Column(
              children: [
                Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                addVerticalSpace(20),
                const Text(
                  'Join the community of KMUTT changemakers with WisMod',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
            Column(
              children: [
                PrimaryButtonMedium(
                  onPressed: () => Get.toNamed(Routes.login),
                  child: const Text('Log In'),
                ),
                addVerticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
