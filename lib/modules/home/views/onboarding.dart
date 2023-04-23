import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Welcome to the Event App!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.login), 
            child: const Text('Sign In'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.login), //TODO: Change to register
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
  }
