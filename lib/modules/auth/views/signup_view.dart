import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';
import '../controllers/signup_controller.dart';

class SignUpView extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());

  final List<String> departmentOptions = [
    'Department',
    'Department of Electrical Engineering',
    'Department of Computer Engineering',
    'Department of Electronic and Telecommunication Engineering',
    'Department of Control System and Instrumentation Engineering',
    'Department of Mechanical Engineering',
    'Department of Civil Engineering',
    'Department of Environmental Engineering',
    'Department of Practical Lead Production Engineering',
    'Department of Tool and Material Engineering',
    'Department of Chemical Engineering',
    'Department of Food Engineering',
    'Department of Biological Engineering',
    'Department of Aquaculture Engineering'
  ];

  final RxString selectedDepartment = RxString('Department');

  SignUpView({super.key});
  bool _validateInputs() {
    String? firstNameError = signUpController
        .validateFirstName(signUpController.firstNameController.text);
    String? lastNameError = signUpController
        .validateLastName(signUpController.lastNameController.text);
    String? yearError =
        signUpController.validateYear(signUpController.yearController.text);
    String? emailError =
        signUpController.validateEmail(signUpController.emailController.text);
    String? passwordError = signUpController
        .validatePassword(signUpController.passwordController.text);
    String? confirmPasswordError = signUpController.validateConfirmPassword(
        signUpController.confirmPasswordController.text);

    if (signUpController.firstNameController.text.isEmpty ||
        signUpController.lastNameController.text.isEmpty ||
        signUpController.yearController.text.isEmpty ||
        signUpController.selectedDepartment.value == 'Department' ||
        signUpController.emailController.text.isEmpty ||
        signUpController.passwordController.text.isEmpty ||
        signUpController.confirmPasswordController.text.isEmpty ||
        firstNameError != null ||
        lastNameError != null ||
        yearError != null ||
        emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // I removed the ios style arrow to go back because we need design to be consistant throughout the app. If you want to make it Ios type arrow, pleease change App Bar theme in theme_data.dart
      // Also avoid putting a leading back button in AppBar, because flutter automatically adds a leading button (if we come from where we do not allo a back then there will be a problem)
      appBar: AppBar(
        title: Text(
          "Register",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'First Name',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormFeildThemed(
                    hintText: "Enter your first name",
                    controller: signUpController.firstNameController,
                    validator: signUpController.validateFirstName,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Last Name',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormFeildThemed(
                    hintText: "Enter your last name",
                    controller: signUpController.lastNameController,
                    validator: signUpController.validateLastName,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Year',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormFeildThemed(
                    keyboardType: TextInputType.number, //Open numeric keyboard on mobile
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], //Force input to be numbers only
                    hintText: "Enter your current year of study at KMUTT",
                    controller: signUpController.yearController,
                    validator: signUpController.validateYear,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Department',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: DropdownButtonFormField<String>(
                      value: signUpController.selectedDepartment.value,
                      items: departmentOptions.map((department) {
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
                      }).toList(),
                      onChanged: (value) => signUpController
                          .selectedDepartment.value = value ?? '',
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
                      validator: signUpController.validateDropdown,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Email',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter your email",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                            ),
                            controller: signUpController.emailController,
                            validator: signUpController.validateEmail,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        '@kmutt.ac.th',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Password',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormFeildThemed(
                    hintText: "Enter your password",
                    controller: signUpController.passwordController,
                    validator: signUpController.validatePassword,
                    obscureText: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Confirm Password',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormFeildThemed(
                    hintText: "Re-enter your password",
                    controller: signUpController.confirmPasswordController,
                    validator: signUpController.validateConfirmPassword,
                    obscureText: true,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButtonMedium(
                      onPressed: () {
                        if (_validateInputs()) {
                          Get.toNamed(Routes.verifyemail);
                        } else {
                          Get.snackbar(
                            'Error',
                            'Please fill in all the fields correctly to create an account.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      child: const Text('Create Account'),
                    ),
                    const SizedBox(height: 16),
                    OutlineButtonMedium(
                      onPressed: () => Get.toNamed(Routes.login),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 38.0),
                        child: Text('Log In'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
