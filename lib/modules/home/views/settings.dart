import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/theme/global_widgets.dart';

import '../../../routes/routes.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: SingleChildScrollView(
          child: PrimaryButtonMedium(
        child: const Text("Accounts"),
        onPressed: () {
          // Get.toNamed(Routes.accounts);
          // Get.offAllNamed(Routes.accounts);
          // Get.offNamed(Routes.accounts);
        },
      )),
    );
  }
}
