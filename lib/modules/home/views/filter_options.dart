import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/utils/app_utils.dart';

import '../controller/home_controller.dart';

//TODO: Apply filter logic, change to sort by location instead since location is string
class FilterOptionsView extends StatelessWidget {
  FilterOptionsView({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.all(sideWidth),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close)),
              ],
            ),
            DropDownCustom(homeController: homeController),
            // addVerticalSpace(),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.5,
            //   child: OutlineButtonMedium(
            //       child: const Text("Location"), onPressed: () {}),
            // ),
            addVerticalSpace(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Obx(() => OutlineButtonMedium(
                  child:
                      Text("Sort by Date : ${homeController.currentDateSort}"),
                  onPressed: () {
                    homeController.sortEventsByDate();
                  })),
            ),
          ],
        ),
      ),
    )));
  }
}

class DropDownCustom extends StatelessWidget {
  const DropDownCustom({
    super.key,
    required this.homeController,
  });
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: DropdownButtonFormField<String>(
        value: homeController.selectedCategory.value,
        items: homeController.categoryOptions.map((category) {
          return dropdownMenuItemCustom(category);
        }).toList(),
        onChanged: homeController.setSelectedCategory,
        style: const TextStyle(
            fontFamily: "Gotham", fontSize: 40, fontWeight: FontWeight.w500),
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(123, 56, 255, 1),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(123, 56, 255, 1),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
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
      ),
    );
  }

  DropdownMenuItem<String> dropdownMenuItemCustom(String category) {
    return DropdownMenuItem(
      value: category,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Center(
          child: Text(
            category,
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
