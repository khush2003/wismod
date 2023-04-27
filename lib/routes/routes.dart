import 'package:get/get.dart';
import 'package:wismod/modules/auth/views/log_in_view.dart';
import 'package:wismod/modules/auth/views/signup_view.dart';
import 'package:wismod/modules/auth/views/verify_email_view.dart';
import 'package:wismod/modules/home/views/all_pages_nav.dart';
import '../modules/home/views/onboarding.dart';

abstract class Routes {
  static const String allPagesNav =
      '/allPagesNav'; // Hold all 4 pages (Home, Chat, Dashboard, Settings with NavBar) so no need of seperate routes
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String verifyemail = '/verifyemail';
  // Add page string (route) here
}

final getPages = [
  GetPage(name: Routes.allPagesNav, page: () => AllPagesNav()),
  GetPage(name: Routes.onboarding, page: () => OnboardingView()),
  GetPage(name: Routes.login, page: () => LogInView()),
  GetPage(name: Routes.signup, page: () => SignUpView()),
  GetPage(name: Routes.verifyemail, page: () => const VerifyEmailView()),
  // Initialize route here
];
