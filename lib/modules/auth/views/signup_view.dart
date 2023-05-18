import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';
import '../controllers/signup_controller.dart';

class SignUpView extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());
  SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(sideWidth),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                feildTitle(context, "First Name"),
                textFeild(
                    hintText: "Enter your first name",
                    controller: signUpController.firstNameController,
                    validator: signUpController.validateFirstName),
                feildTitle(context, "Last Name"),
                textFeild(
                    hintText: "Enter your last name",
                    controller: signUpController.lastNameController,
                    validator: signUpController.validateLastName),
                feildTitle(context, "Year"),
                textFeild(
                    hintText: "Enter your current year of study at KMUTT",
                    controller: signUpController.yearController,
                    validator: signUpController.validateYear,
                    keyboardType:
                        TextInputType.number, //Open numeric keyboard on mobile
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ]),
                feildTitle(context, "Department"),
                DropDownCustom(signUpController: signUpController),
                feildTitle(context, "Email"),
                EmailWithHelper(signUpController: signUpController),
                feildTitle(context, "Password"),
                textFeild(
                    hintText: "Enter your password",
                    controller: signUpController.passwordController,
                    validator: signUpController.validatePassword,
                    obscureText: true),
                feildTitle(context, "Confirm Password"),
                textFeild(
                    hintText: "Re-enter your password",
                    controller: signUpController.confirmPasswordController,
                    validator: signUpController.validateConfirmPassword,
                    obscureText: true),
                const SizedBox(height: 16),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButtonMedium(
                          onPressed: () async {
                            await signUpController.registerUser();
                          },
                          child: const Text('Create Account'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding textFeild(
      {required String hintText,
      required TextEditingController? controller,
      required String? Function(String?)? validator,
      bool? obscureText,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
      child: TextFormFeildThemed(
          hintText: hintText,
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType, //Open numeric keyboard on mobile
          inputFormatters: inputFormatters),
    );
  }

  Padding feildTitle(BuildContext context, String feildname) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
      child: Text(
        feildname,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}

class EmailWithHelper extends StatelessWidget {
  const EmailWithHelper({
    super.key,
    required this.signUpController,
  });

  final SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
      child: Row(
        children: [
          Expanded(
              child: TextFormFeildThemed(
                  controller: signUpController.emailController,
                  validator: signUpController.validateEmail,
                  hintText: "Enter your email (first part)")),
          addHorizontalSpace(),
          Text("@kmutt.ac.th", style: Theme.of(context).textTheme.displayLarge)
        ],
      ),
    );
  }
}

class DropDownCustom extends StatelessWidget {
  const DropDownCustom({
    super.key,
    required this.signUpController,
  });

  final SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        child: Obx(() => DropdownButtonFormField<String>(
              value: signUpController.selectedDepartment.value,
              items: signUpController.departmentOptions.map((department) {
                return dropdownMenuItemCustom(department);
              }).toList(),
              onChanged: (value) =>
                  signUpController.selectedDepartment.value = value ?? '',
              decoration: const InputDecoration(
                hintText: 'Department',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(123, 56, 255, 1),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15.0,
                ),
                hintStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(123, 56, 255, 1),
                ),
              ),
              dropdownColor: Colors.white,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color.fromRGBO(123, 56, 255, 1),
              ),
              iconSize: 32,
              elevation: 2,
              isExpanded: true,
            )),
      ),
    );
  }

  DropdownMenuItem<String> dropdownMenuItemCustom(String department) {
    return DropdownMenuItem(
      value: department,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Center(
          child: Text(
            department,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color.fromRGBO(123, 56, 255, 1),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
