import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/theme/theme_data.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../../routes/routes.dart';

//explaine this code to me
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  // final _auth = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Column(
              children: [
                TileButton(
                  onPressed: () => Get.toNamed(Routes.accounts),
                  text: 'Account',
                ),
                // TileButton(
                //   onPressed: () => Get.toNamed(Routes.notficaition),
                //   text: 'Notification',
                // ),
                TileButton(
                  onPressed: () => Get.toNamed(Routes.help),
                  text: 'Help',
                ),
                TileButton(
                  onPressed: () => Get.toNamed(Routes.blockList),
                  text: 'Blocked Chat Groups',
                ),
                addVerticalSpace(),
                AlertLogOut(),
              ],
            )),
          )),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Settings",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      centerTitle: true,
      toolbarHeight: 60,
    );
  }
}

class TileButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const TileButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(text,
                          style: const TextStyle(
                              fontFamily: "Gotham",
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white)),
                      const Icon(Icons.arrow_forward_ios, size: 24)
                    ],
                  ),
                ))));
  }
}

class AlertLogOut extends StatelessWidget {
  AlertLogOut({super.key});
  final _auth = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              // contentPadding: EdgeInsets.all(24.0),
              title: const Text('Do you want to logout?',
                  style: TextStyle(
                      fontFamily: "Gotham",
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.black)),
              // content: const Text('AlertDialog description'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                        child: OutlineButtonMedium(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('No',
                              style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  color: Color.fromRGBO(123, 56, 255, 1))),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                        child: OutlineButtonMedium(
                          onPressed: () async => await _auth.logout(),
                          child: const Text('Yes',
                              style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  color: Color.fromRGBO(123, 56, 255, 1))),
                        )),
                  ],
                ),
              ],
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
            child: Text("Log out",
                style: TextStyle(
                    fontFamily: "Gotham",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 255, 255))),
          ),
        ),
      ),
    );
  }
}
