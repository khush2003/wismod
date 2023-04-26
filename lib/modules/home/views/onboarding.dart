import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});
  final thc = Get.put(ThemedSwitchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 40.0),
                  child: Text(
                    'Welcome to',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://drive.google.com/file/d/1iVtDq_M5nygA6tqZxDR9yrBMWX1noPff/view',
                  height: 200,
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 90.0, 8.0, 90.0),
              child: Text(
                'Join the community of KMUTT changemakers with WisMod',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 50),
            PrimaryButtonMedium(
              onPressed: () => Get.toNamed(Routes.login),
              child: const Text('Log In'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Doesn't have an account? ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/signup');
                  },
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromRGBO(123, 56, 255, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
      bottomNavigationBar: Wrap(
        spacing: 10,
        children: [
          Text(
            'Welcome to the Event App!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          PrimaryButtonMedium(
            onPressed: () => Get.toNamed(Routes.login),
            child: const Text('Sign In'),
          ),
          PrimaryButtonLarge(
            onPressed: () => Get.toNamed(Routes.allPagesNav),
            child: const Text('Register'),
          ),
          SecondaryButtonMedium(
            onPressed: () => Get.toNamed(Routes.allPagesNav),
            child: const Text('Sign In'),
          ),
          SecondaryButtonLarge(
            onPressed: () => Get.toNamed(Routes.login),
            child: const Text('Sign In'),
          ),
          OutlineButtonMedium(
            onPressed: () => Get.toNamed(Routes.login),
            child: const Text('Sign In'),
          ),
          OutlineButtonLarge(
            onPressed: () => Get.toNamed(Routes.login),
            child: const Text('Sign In'),
          ),
          const TextFormFeildThemed(hintText: "Hello"),
          const TextAreaThemed(hintText: "Type Here"),
          ThemedSwitch(),
          Obx(() => Text(thc.isOn.value.toString()))
        ],
      ),
    );
  }
}
