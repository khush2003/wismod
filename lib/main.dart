import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wismod/firebase_options.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/routes/routes.dart';
import 'package:wismod/theme/theme_data.dart';
import 'package:get/get.dart';
void main() async {
  // Initializing Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
