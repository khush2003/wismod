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
            LogoImage(),
            GetStarted(),
          ],
        ),
      ),
    );
  }
}

class GetStarted extends StatelessWidget {
  const GetStarted({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButtonMedium(
        onPressed: () => Get.toNamed(Routes.login),
        child: const Text("Let's start"),
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/IconWisMod.png',
          height: 90,
          fit: BoxFit.fill,
          color: const Color.fromRGBO(123, 56, 255, 1),
        ),
        const Text(
          'WISMOD',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 72,
              color: Color.fromRGBO(123, 56, 255, 1)),
        ),
        VerticalSpace(),
        const Text(
          'Work like mods',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.black),
        ),
      ],
    );
  }
}

