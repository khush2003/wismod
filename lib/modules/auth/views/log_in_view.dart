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
        body: Padding(
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
                    const Expanded(
                        child: TextFormFeildThemed(
                            hintText: "Enter your email (first part)")),
                    addHorizontalSpace(),
                    Text("@kmutt.ac.th", style: tt.displayLarge)
                  ],
                ),
                addVerticalSpace(20),
                const Text("Password",
                    style: TextStyle(
                        fontFamily: "Gotham",
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                addVerticalSpace(),
                Obx(() => SizedBox(
                      child: TextFormFeildThemed(
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
                    )),
                addVerticalSpace(20),
                Center(
                  child: PrimaryButtonMedium(
                    onPressed: () => Get.toNamed(Routes.home),
                    size: const Size(170, 40),
                    child: const Text("Login"),
                  ),
                ),
                addVerticalSpace(10),
                Center(
                    child: OutlineButtonMedium(
                  size: const Size(170, 40),
                  child: const Text("Register"),
                  onPressed: () => Get.toNamed(Routes.signup),
                ))
              ],
            ))));
  }
}
