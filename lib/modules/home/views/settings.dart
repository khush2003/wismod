import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';

import '../../../routes/routes.dart';

//explaine this code to me
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  // final _auth = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(201, 173, 255, 1),
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlineButtonMedium(
                      child:
                          const Text("Account", style: TextStyle(fontSize: 24)),
                      onPressed: () {
                        Get.toNamed(Routes.accounts);
                        // Get.offAllNamed(Routes.accounts);
                        // Get.offNamed(Routes.accounts);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlineButtonMedium(
                      child: const Text("Notification",
                          style: TextStyle(fontSize: 24)),
                      onPressed: () {
                        // Get.toNamed(Routes.accounts);
                        // Get.offAllNamed(Routes.accounts);
                        // Get.offNamed(Routes.accounts);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlineButtonMedium(
                      child: const Text("Help", style: TextStyle(fontSize: 24)),
                      onPressed: () {
                        // Get.toNamed(Routes.accounts);
                        // Get.offAllNamed(Routes.accounts);
                        // Get.offNamed(Routes.accounts);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlineButtonMedium(
                      child: const Text("Block list",
                          style: TextStyle(fontSize: 24)),
                      onPressed: () {
                        // Get.toNamed(Routes.accounts);
                        // Get.offAllNamed(Routes.accounts);
                        // Get.offNamed(Routes.accounts);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
                  child: AlertLogOut(),
                ),
              ],
            )),
          )),
    );
  }
}

class AlertLogOut extends StatelessWidget {
  AlertLogOut({super.key});
  final _auth = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlineButtonMedium(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            // contentPadding: EdgeInsets.all(24.0),
            title: const Text('Do you want to logout?',
                style: TextStyle(fontSize: 32)),
            // content: const Text('AlertDialog description'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                      child: OutlineButtonMedium(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('No', style: TextStyle(fontSize: 32)),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                      child: OutlineButtonMedium(
                        onPressed: () async => await _auth.logout(),
                        child:
                            const Text('Yes', style: TextStyle(fontSize: 32)),
                      )),
                ],
              ),
            ],
          ),
        ),
        child: const Text("Log out", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
