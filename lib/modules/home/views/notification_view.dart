import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/theme/global_widgets.dart';

import '../../../routes/routes.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Account",
        style: TextStyle(
            fontFamily: "Gotham",
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.black),
      )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 0.0),
        child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Column(children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Chat notification",
                        style: TextStyle(
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      ThemedSwitch()
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Event update notification",
                        style: TextStyle(
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      ThemedSwitch()
                    ],
                  )),
            ]))),
      ),
    );
  }
}
