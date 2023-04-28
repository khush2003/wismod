import 'package:get/get.dart';

enum Pages { homePage, chatPage, dashboardPage, settingsPage }

class AllPagesNavController extends GetxController {
  late final int pageIndex = 1;
  late final Rx<int> tabIndex = pageIndex.obs;
  @override
  void onInit() {
    super.onInit();
    final int initialPage = convertPagestoNumber(Pages.homePage);
    final int pageIndex = Get.arguments != null
        ? convertPagestoNumber(Get.arguments['page'])
        : initialPage;
    changeTabIndex(pageIndex);
  }

  void changeTabIndex(int index) {
    tabIndex(index);
  }

  int convertPagestoNumber(Pages k) {
    switch (k) {
      case Pages.homePage:
        return 0;
      case Pages.chatPage:
        return 1;
      case Pages.dashboardPage:
        return 2;
      case Pages.settingsPage:
        return 3;
      default:
        return 0;
    }
  }
}
