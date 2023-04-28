import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wismod/routes/routes.dart';

class AuthManager extends GetMiddleware {
  @override
  int? get priority => 0;

  @override
  RouteSettings? redirect(String? route) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        return const RouteSettings(name: Routes.allPagesNav);
      } else {
        return const RouteSettings(name: Routes.verifyemail);
      }
    }

    return null;
  }
}
