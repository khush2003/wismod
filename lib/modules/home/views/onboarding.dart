import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';
import '../../auth/controllers/log_in_controller.dart';

class OnboardingView extends StatelessWidget {
  final logInController = Get.put(LogInController());
  OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(sideWidth),
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/IconWisMod.png',
                      height: 90,
                      fit: BoxFit.fill,
                      color: const Color.fromRGBO(123, 56, 255, 1),
                    ),
                    Column(
                      children: [
                        Column(
                          children: [
                            const Text(
                              'WISMOD',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 72,
                                  color: Color.fromRGBO(123, 56, 255, 1)),
                            ),
                            addVerticalSpace(2),
                            const Text(
                              'Work like mods',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                        Row(children: [
                          Text("Password",
                              style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                          TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.forgot);
                              },
                              child: Text("Forgot password?",
                                  style: TextStyle(
                                      fontFamily: "Gotham",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)))
                        ]),
                        // addVerticalSpace(),
                        Obx(
                          () => SizedBox(
                            child: TextFormFeildThemed(
                                controller: logInController.passwordController,
                                hintText: "Enter your password",
                                enableSuggestions: false,
                                autocorrect: false,
                                obscureText: !logInController.isvisible.value,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      logInController.toogleVisible();
                                    },
                                    icon: logInController.isvisible.value
                                        ? const Icon(
                                            Icons.visibility_off_outlined)
                                        : const Icon(
                                            Icons.visibility_outlined))),
                          ),
                        )
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButtonMedium(
                          onPressed: () async =>
                              await logInController.loginUser(),
                          child: const Text("Login"),
                        ),
                      ),
                      addVerticalSpace(),
                      Column(
                        children: [
                          const Text(
                            "Don't have an account? ",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 16, fontFamily: "Gotham"),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.signup);
                            },
                            child: const Text(
                              'Create Account',
                              style: TextStyle(
                                fontFamily: 'Gotham',
                                decoration: TextDecoration.underline,
                                color: Color.fromRGBO(123, 56, 255, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
