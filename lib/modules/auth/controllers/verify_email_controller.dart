import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  var canResend = false;

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      canResend = true;
    });
    super.onInit();
  }
}
