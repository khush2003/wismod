import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/modules/auth/controllers/signup_controller.dart';

import '../../../routes/routes.dart';

class AccountsView extends StatelessWidget {
  const AccountsView({super.key});

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
                child: Account_sections(
                  label: 'First name',
                  hintText: 'Your first name',
                  trailingWidget: const Text(
                    'Change first name',
                    style: TextStyle(
                      fontFamily: "Gotham",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromRGBO(123, 56, 255, 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: Account_sections(
                  label: 'Last name',
                  hintText: 'Your last name',
                  trailingWidget: const Text(
                    'Change last name',
                    style: TextStyle(
                      fontFamily: "Gotham",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromRGBO(123, 56, 255, 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: Department_sections(
                  label: 'Department',
                  trailingWidget: const Text(
                    'Change first name',
                    style: TextStyle(
                      fontFamily: "Gotham",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromRGBO(123, 56, 255, 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: Account_sections(
                  label: 'Year',
                  hintText: 'Your year',
                  trailingWidget: const Text(
                    'Change year',
                    style: TextStyle(
                      fontFamily: "Gotham",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromRGBO(123, 56, 255, 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: PrimaryButtonMedium(
                    child: const Text("Change password",
                        style: TextStyle(
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Color.fromRGBO(255, 255, 255, 1))),
                    onPressed: () {
                      // Get.toNamed(Routes.accounts);
                      // Get.offAllNamed(Routes.accounts);
                      // Get.offNamed(Routes.accounts);
                    },
                  ),
                ),
              ),
            ]))),
      ),
    );
  }
}

class Account_sections extends StatelessWidget {
  final String label;
  final String hintText;
  final Widget trailingWidget;

  const Account_sections({
    Key? key,
    required this.label,
    required this.hintText,
    required this.trailingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: "Gotham",
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Color.fromRGBO(123, 56, 255, 1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SizedBox(
            width: double.infinity,
            child: TextFormFeildThemed(
              hintText: hintText,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: OutlineButtonMedium(
            child: trailingWidget,
            onPressed: () {
              // Pressed effect here
            },
          ),
        ),
      ],
    );
  }
}

class Department_sections extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());
  final String label;
  final Widget trailingWidget;

  Department_sections({
    Key? key,
    required this.label,
    required this.trailingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: "Gotham",
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Color.fromRGBO(123, 56, 255, 1),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: DropDownCustom(signUpController: signUpController)),
        SizedBox(
          width: double.infinity,
          child: OutlineButtonMedium(
            child: trailingWidget,
            onPressed: () {
              // Pressed effect here
            },
          ),
        ),
      ],
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
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        child: DropdownButtonFormField<String>(
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
          validator: signUpController.validateDropdown,
        ),
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
