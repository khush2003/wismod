import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';

enum Pages { homePage, chatPage, dashboardPage, settingsPage, adminPage }

class AllPagesNavController extends GetxController {
  final _auth = AuthController.instance;
  late final Rx<int> tabIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    final int initialPage = convertPagestoNumber(Pages.homePage);
    final int pageIndex = Get.arguments != null
        ? convertPagestoNumber(Get.arguments['page'])
        : initialPage;
    changeTabIndex(pageIndex);
  }

  bool checkIsAdmin() {
    if (_auth.appUser.value.isAdmin != null) {
      if (_auth.appUser.value.isAdmin!) {
        return true;
      }
    }
    return false;
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
      case Pages.adminPage:
        return 4;
      default:
        return 0;
    }
  }
}
