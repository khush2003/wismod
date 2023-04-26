import 'package:get/get.dart';

class AllPagesNavController extends GetxController {
  var tabIndex = 0.obs;
  void changeTabIndex(int index) {
    tabIndex(index);
  }
}
