import 'package:get/get.dart';
import 'package:wismod/modules/auth/views/log_in_view.dart';
import 'package:wismod/modules/auth/views/signup_view.dart';
import 'package:wismod/modules/home/views/accounts.dart';
import 'package:wismod/modules/home/views/all_pages_nav.dart';
import 'package:wismod/modules/home/views/block_list.dart';
import 'package:wismod/modules/home/views/filter_options.dart';
import 'package:wismod/modules/home/views/notification.dart';
import 'package:wismod/modules/home/views/password.dart';
import '../modules/home/views/event_details.dart';
import '../modules/home/views/onboarding.dart';
import '../modules/home/views/create_event.dart';
import '../modules/home/views/chatting.dart';
import '../middleware/page_route_middleware.dart';

abstract class Routes {
  static const String allPagesNav =
      '/allPagesNav'; // Hold all 4 pages (Home, Chat, Dashboard, Settings with NavBar) so no need of seperate routes
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String createEvent = '/createEvent';
  static const String accounts = '/accounts';
  static const String password = '/password';
  static const String notficaition = '/notficaition';
  static const String blockList = '/blockList';
  static const String eventDetials = '/eventDetails';
  static const String filterOptions = '/filterOptions';
  static const String chatting = '/chatting';
  // Add page string (route) here
}

final getPages = [
  GetPage(name: Routes.allPagesNav, page: () => AllPagesNav()),
  GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingView(),
      middlewares: [AuthManager()]),
  GetPage(name: Routes.login, page: () => LogInView()),
  GetPage(name: Routes.signup, page: () => SignUpView()),
  GetPage(name: Routes.createEvent, page: () => CreateEventView()),
  GetPage(name: Routes.accounts, page: () => const AccountsView()),
  GetPage(name: Routes.password, page: () => const PassWordView()),
  GetPage(name: Routes.notficaition, page: () => NotificationView()),
  GetPage(name: Routes.blockList, page: () => const BlockListView()),
  GetPage(name: Routes.eventDetials, page: () => EventDetailView()),
  GetPage(
      name: Routes.filterOptions,
      page: () => FilterOptionsView(),
      transition: Transition.rightToLeft),
  GetPage(name: Routes.chatting, page: () => const ChattingView()),
  // Initialize route here
];
