import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});
  final thc = Get.put(ThemedSwitchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 25.0),
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
              Image.asset(
                'assets/images/WisModLonger.png',
                height: 200,
              ),
            ],
          ),
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 70.0, 8.0, 110.0),
            child: Text(
              'Join the community of KMUTT changemakers with WisMod',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
          ),
          const Expanded(
            child: Text(""),
          ),
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
    );
  }
}
