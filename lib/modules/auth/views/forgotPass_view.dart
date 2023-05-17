import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/log_in_controller.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/utils/app_utils.dart';
import '../../../routes/routes.dart';

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
                const Text("Email",
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
                addVerticalSpace(20),
                Center(
                    child: Text(
                        "We'll sent the password changing mail to your email ")),
                addVerticalSpace(20),
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

  void _changeText() {
    setState(() {
      text = "Send Password changing mail again";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButtonMedium(
        onPressed: () {
          logInController.sendMail();
          if (logInController.isButtonClicked() == true) {
            setState(() {
              _changeText();
            });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mail_outlined),
            addHorizontalSpace(10),
            Text('$text')
          ],
        ),
      ),
    );
  }
}
