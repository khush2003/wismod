import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wismod/theme/global_widgets.dart';
import '../../controller/account_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/app_utils.dart';

class AccountsView extends StatelessWidget {
  AccountsView({super.key});
  final AccountController accountController = Get.put(AccountController());

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
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: AccountSections(
                  label: 'Name',
                  hintText: 'Your first name and last name',
                  validator: accountController.validateName,
                  controllerFunction: accountController.nameController,
                  trailingWidget: const Text(
                    'Change Name',
                    style: TextStyle(
                      fontFamily: "Gotham",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromRGBO(123, 56, 255, 1),
                    ),
                  ),
                  onPressed: () {
                    accountController.updateName();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: DepartmentSections(
                  controller: accountController,
                  label: 'Department',
                  trailingWidget: const Text(
                    'Change department',
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
                child: AccountSections(
                  isNumeric: true,
                  label: 'Year',
                  validator: accountController.validateYear,
                  hintText: 'Your year',
                  controllerFunction: accountController.yearController,
                  trailingWidget: const Text(
                    'Change year',
                    style: TextStyle(
                      fontFamily: "Gotham",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromRGBO(123, 56, 255, 1),
                    ),
                  ),
                  onPressed: () {
                    accountController.updateYear();
                  },
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
                      Get.toNamed(Routes.password);
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

class AccountSections extends StatelessWidget {
  final String label;
  final String hintText;
  final Widget trailingWidget;
  final TextEditingController controllerFunction;
  final bool isNumeric;
  final FormFieldValidator<String>? validator;

  final VoidCallback onPressed;
  const AccountSections({
    Key? key,
    required this.label,
    required this.hintText,
    required this.trailingWidget,
    required this.controllerFunction,
    this.isNumeric = false,
    this.validator,
    required this.onPressed,
  }) : super(key: key);

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
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              child: TextFormFeildThemed(
                validator: validator,
                keyboardType: isNumeric ? TextInputType.number : null,
                inputFormatters: isNumeric
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ]
                    : null,
                hintText: hintText,
                controller: controllerFunction,
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: OutlineButtonMedium(
            onPressed: onPressed,
            child: trailingWidget,
          ),
        ),
      ],
    );
  }
}

class DepartmentSections extends StatelessWidget {
  final AccountController controller;
  final String label;
  final Widget trailingWidget;

  const DepartmentSections({
    Key? key,
    required this.controller,
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
          style: const TextStyle(
            fontFamily: "Gotham",
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        addVerticalSpace(),
        Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: DropDownCustom(controller: controller)),
        SizedBox(
          width: double.infinity,
          child: OutlineButtonMedium(
            child: trailingWidget,
            onPressed: () {
              controller.updateDepartment();
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
    required this.controller,
  });

  final AccountController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        child: Obx(() => DropdownButtonFormField<String>(
              value: controller.selectedDepartment.value,
              items: controller.departmentOptions.map((department) {
                return dropdownMenuItemCustom(department);
              }).toList(),
              onChanged: (value) => controller.selectedDepartment.value =
                  value ?? controller.selectedDepartment.value,
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
