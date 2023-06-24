import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/log_in_controller.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/utils/app_utils.dart';

class ForgotView extends StatelessWidget {
  ForgotView({super.key});
  final logInController = Get.put(LogInController());
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(sideWidth),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Email of your account",
                    style: TextStyle(
                        fontFamily: "Gotham",
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                addVerticalSpace(),
                Row(
                  children: [
                    Expanded(
                        child: TextFormFeildThemed(
                            controller: logInController.emailController,
                            hintText: "Enter your email (first part)")),
                    addHorizontalSpace(),
                    Text("@kmutt.ac.th", style: tt.displayLarge)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Center(
                      child: Text(
                          "Make sure that email is the one you've been registered with.")),
                ),
                Center(
                  //button was here
                  child: MyStatefulWidget(),
                ),
                addVerticalSpace(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({
    Key? key,
  }) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final LogInController logInController = Get.put(LogInController());
  String text = "Send Password changing mail";
  bool buttonClicked = false;

  void _changeTextInsideButton() {
    setState(() {
      text = "Send Password changing mail again";
    });
  }

  void _changeTextMessage() {
    setState(() {
      text = "Send Password changing mail again";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (buttonClicked)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Transform.translate(
                  offset: const Offset(0,
                      3), // Adjust the offset to align the icon with the desired position
                  child: Icon(
                    Icons.check_circle,
                    size: 17,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "Re-setting password mail has been sent to your email. If your email hasn't received any mail, you can try clicking the reset password button again",
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color.fromARGB(255, 255, 77, 143)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          Container(),
        SizedBox(
          width: double.infinity,
          child: PrimaryButtonMedium(
            onPressed: () {
              logInController.sendMail();
              if (logInController.isButtonClicked() == true) {
                setState(() {
                  _changeTextInsideButton();
                  buttonClicked = true;
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mail_outlined),
                SizedBox(width: 10),
                Text('$text'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
