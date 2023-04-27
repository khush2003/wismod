import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';

class SignUpView extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text("Register", style: Theme.of(context).textTheme.titleMedium)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'First Name',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: TextFormFeildThemed(
                    hintText: "Enter your first name",
                    controller: firstNameController),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Last Name',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: TextFormFeildThemed(
                    hintText: "Enter your last name",
                    controller: lastNameController),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Year',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: TextFormFeildThemed(
                    hintText: "Enter your academic year at KMUTT",
                    controller: firstNameController),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Department',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: DropdownButtonFormField<String>(
                    value: selectedDepartment.value,
                    items: departmentOptions.map((department) {
                      return DropdownMenuItem(
                        value: department,
                        child: Text(
                          department,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(123, 56, 255, 1),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        selectedDepartment.value = value ?? '',
                    decoration: InputDecoration(
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
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color.fromRGBO(123, 56, 255, 1),
                    ),
                    iconSize: 32,
                    elevation: 2,
                    isExpanded: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
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
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            border: OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                          ),
                          controller: emailController,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: const Text(
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
                padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Password',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: TextFormFeildThemed(
                    hintText: "Enter your password",
                    controller: firstNameController),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                child: Text(
                  'Confirm Password',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 16.0),
                child: TextFormFeildThemed(
                    hintText: "RE-enter your password",
                    controller: firstNameController),
              ),
              SizedBox(height: 24),
              PrimaryButtonMedium(
                onPressed: () => Get.toNamed(Routes.verifyemail),
                child: const Text('Create Account'),
              ),
              SizedBox(height: 16),
              OutlineButtonMedium(
                onPressed: () => Get.toNamed(Routes.login),
                child: const Text('Lof In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class SignUpView extends StatelessWidget {
//   const SignUpView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Sign Up haaha")),
//     );
//   }
// }
