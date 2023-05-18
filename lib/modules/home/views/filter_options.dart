import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/utils/app_utils.dart';

import '../controller/home_controller.dart';

class FilterOptionsView extends StatelessWidget {
  FilterOptionsView({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(sideWidth),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Center(
        child: Column(
          children: [
            DropDownCustom(homeController: homeController),
            addVerticalSpace(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Obx(() => OutlineButtonMedium(
                  borderRadius: 15,
                  child:
                      Text("Sort by Date : ${homeController.currentDateSort}"),
                  onPressed: () {
                    homeController.sortEventsByDate();
                  })),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlineButtonMedium(
                    child: const Text("Clear Filters"),
                    onPressed: () {
                      homeController.generateSmartFeed();
                      homeController.selectedCategory('Default');
                      homeController.currentDateSort('None').obs;
                    }),
                addHorizontalSpace(),
                PrimaryButtonMedium(
                    child: const Text("Apply"), onPressed: () => Get.back()),
              ],
            )
          ],
        ),
      ),
    );
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
      width: MediaQuery.of(context).size.width,
      child: Obx(() => DropdownButtonFormField<String>(
            value: homeController.selectedCategory.value,
            items: homeController.categoryOptions.map((category) {
              return dropdownMenuItemCustom(category);
            }).toList(),
            onChanged: homeController.setSelectedCategory,
            style: const TextStyle(
                fontFamily: "Gotham",
                fontSize: 40,
                fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromRGBO(123, 56, 255, 1),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  width: 2,
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
          )),
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
