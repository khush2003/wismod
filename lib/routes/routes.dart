import 'package:get/get.dart';
import 'package:wismod/modules/auth/views/forgotPass_view.dart';
import 'package:wismod/modules/auth/views/log_in_view.dart';
import 'package:wismod/modules/auth/views/signup_view.dart';
import 'package:wismod/modules/home/views/help_pages/chat_1.dart';
import 'package:wismod/modules/home/views/help_pages/dashboard_1.dart';
import 'package:wismod/modules/home/views/help_pages/whatWisMod.dart';
import 'package:wismod/modules/home/views/setting_pages/accounts.dart';
import 'package:wismod/modules/home/views/all_pages_nav.dart';
import 'package:wismod/modules/home/views/setting_pages/block_list.dart';
import 'package:wismod/modules/home/views/edit_event.dart';
import 'package:wismod/modules/home/views/help_pages/event_1.dart';
import 'package:wismod/modules/home/views/help_pages/event_2.dart';
import 'package:wismod/modules/home/views/help_pages/event_3.dart';
import 'package:wismod/modules/home/views/help_pages/help.dart';
import 'package:wismod/modules/home/views/setting_pages/notification.dart';
import 'package:wismod/modules/home/views/setting_pages/password.dart';
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
  static const String editEvent = '/editEvent';
  static const String accounts = '/accounts';
  static const String password = '/password';
  static const String notficaition = '/notficaition';
  static const String blockList = '/blockList';
  static const String eventDetials = '/eventDetails';
  static const String chatting = '/chatting';
  static const String help = '/help';
  static const String event_1 = '/event_1';
  static const String event_2 = '/event_2';
  static const String event_3 = '/event_3';
  static const String chat_1 = '/chat_1';
  static const String dashBoard_1 = '/dashBoard_1';
  static const String forgot = '/forgot';
  static const String whatWismod = '/whatWismod';
  // Add page string (route) here
}

final getPages = [
  GetPage(name: Routes.allPagesNav, page: () => AllPagesNav()),
  GetPage(
      name: Routes.onboarding,
      page: () => OnboardingView(),
      middlewares: [AuthManager()]),
  GetPage(name: Routes.login, page: () => LogInView()),
  GetPage(name: Routes.signup, page: () => SignUpView()),
  GetPage(name: Routes.createEvent, page: () => CreateEventView()),
  GetPage(name: Routes.editEvent, page: () => EditEvent()),
  GetPage(
      name: Routes.accounts,
      page: () => AccountsView(),
      transition: Transition.rightToLeft),
  GetPage(name: Routes.password, page: () => PassWordView()),
  GetPage(
      name: Routes.notficaition,
      page: () => NotificationView(),
      transition: Transition.rightToLeft),
  GetPage(
      name: Routes.blockList,
      page: () => BlockListView(),
      transition: Transition.rightToLeft),
  GetPage(
      name: Routes.eventDetials,
      page: () => EventDetailView(),
      transition: Transition.circularReveal),
  GetPage(name: Routes.chatting, page: () => ChattingView()),
  GetPage(
      name: Routes.help,
      page: () => const HelpView(),
      transition: Transition.rightToLeft),
  GetPage(name: Routes.event_1, page: () => const HelpEvent1()),
  GetPage(name: Routes.event_2, page: () => const HelpEvent2()),
  GetPage(name: Routes.event_3, page: () => const HelpEvent3()),
  GetPage(name: Routes.chat_1, page: () => const HelpChat1()),
  GetPage(name: Routes.dashBoard_1, page: () => const HelpDashBoard1()),
  GetPage(name: Routes.forgot, page: () => ForgotView()),
  GetPage(name: Routes.whatWismod, page: () => WhatWisMod()),
  // Initialize route here
];
