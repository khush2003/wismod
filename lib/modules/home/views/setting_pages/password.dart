import 'package:flutter/material.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:get/get.dart';
import '../../controller/password_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../utils/app_utils.dart';

class PassWordView extends StatelessWidget {
  PassWordView({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  // final TextEditingController passwordController = TextEditingController();
  // final TextEditingController confirmPasswordController =
  //     TextEditingController();
  final PasswordController passwordController = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Password",
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
              child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                      child: HeadAndTextField(
                        label: 'Current Password',
                        hintText: 'Type you current password',
                        validateFunction: passwordController.validatePassword,
                        controllerFunction:
                            passwordController.currentPasswordController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                      child: HeadAndTextField(
                        label: 'New password',
                        hintText: 'Input your new password',
                        validateFunction: passwordController.validatePassword,
                        controllerFunction:
                            passwordController.passwordController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                      child: HeadAndTextField(
                        label: 'Confirm New password',
                        hintText: 'Retype your new password',
                        validateFunction:
                            passwordController.validateConfirmPassword,
                        controllerFunction:
                            passwordController.confirmPasswordController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: AlertPasswordChange(
                              controller: passwordController)),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                    //   child: SizedBox(
                    //     width: double.infinity,
                    //     child: AlertPassWordCancel(),
                    //   ),
                    // ),
                  ]))),
        ),
      ),
    );
  }
}

class HeadAndTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? Function(String?)? validateFunction;
  final TextEditingController? controllerFunction;

  const HeadAndTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.validateFunction,
    this.controllerFunction,
  }) : super(key: key);

  String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? validate(String? value) =>
      value == null || value.isEmpty ? 'This field cannot be empty' : null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: "Gotham",
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        addVerticalSpace(),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SizedBox(
            width: double.infinity,
            child: TextFormFeildThemed(
              hintText: hintText,
              validator: validateFunction ?? validate,
              controller: controllerFunction,
              obscureText: true,
            ),
          ),
        ),
      ],
    );
  }
}

class AlertPasswordChange extends StatelessWidget {
  // final Future<void> Function() onpressedYesFunction;
  final PasswordController controller;
  const AlertPasswordChange({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButtonMedium(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            // contentPadding: EdgeInsets.all(24.0),
            title: const Text('Do you want to change your password?',
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
                          onPressed: () {
                            controller.changePassword();
                            Navigator.pop(context, 'Yes');
                          },
                          child: const Text('Yes',
                              style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  color: Color.fromRGBO(123, 56, 255, 1)))
                          // print("Password changed");
                          // Get.back();

                          )),
                ],
              ),
            ],
          ),
        ),
        child: const Text("Change password",
            style: TextStyle(
                fontFamily: "Gotham",
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255))),
      ),
    );
  }
}

class AlertPassWordCancel extends StatelessWidget {
  const AlertPassWordCancel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButtonMedium(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            // contentPadding: EdgeInsets.all(24.0),
            title: const Text('Do you want to change your password?',
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
                        onPressed: () {},
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
        child: const Text(
          "Cancel",
          style: TextStyle(
              fontFamily: "Gotham",
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}
