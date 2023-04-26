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
      body: Wrap(
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
            onPressed: () =>
                Get.toNamed(Routes.allPagesNav), //TODO: Change to register
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
