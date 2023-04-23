import 'package:get/get.dart';
import 'package:wismod/modules/auth/views/log_in_view.dart';

import '../modules/home/views/home.dart';
import '../modules/home/views/onboarding.dart';

abstract class Routes {
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
}

final getPages = [
  GetPage(name: Routes.home, page: () => const HomeView()),
  GetPage(name: Routes.onboarding, page: () => const OnboardingView()),
  GetPage(name: Routes.login, page: () => const LogInView())
];
