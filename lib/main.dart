import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wismod/firebase_options.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/routes/routes.dart';
import 'package:wismod/theme/theme_data.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  // Initializing Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.getInitialMessage();
  await FirebaseMessaging.instance.subscribeToTopic('all');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Get.put(AuthController());
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WisMod',
      theme: AppThemeData.themedata,
      initialRoute: Routes.onboarding,
      getPages: getPages,
    );
  }
}
