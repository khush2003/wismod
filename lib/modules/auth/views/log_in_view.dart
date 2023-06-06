import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/log_in_controller.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/utils/app_utils.dart';
import '../../../routes/routes.dart';

class LogInView extends StatelessWidget {
  LogInView({super.key});
  final logInController = Get.put(LogInController());
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
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
                                ? const Icon(Icons.visibility_off_outlined)
                                : const Icon(Icons.visibility_outlined))),
                  ),
                ),
                addVerticalSpace(20),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryButtonMedium(
                      onPressed: () async => await logInController.loginUser(),
                      child: const Text("Log In"),
                    ),
                  ),
                ),
                addVerticalSpace(10),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        "Didn't have an account? ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontFamily: "Gotham"),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
