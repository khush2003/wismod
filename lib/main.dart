import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:wismod/firebase_options.dart';
import 'package:wismod/routes/routes.dart';
import 'package:wismod/theme/theme_data.dart';

void main() async {
  // Initializing Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      //TODO: Implement Function to route user to login screen if it is not his first time on the app.
      //TODO: Add global/app-wide theme (Stored in theme folder)
      initialRoute: Routes.onboarding, // Goes to Onboarding Page Initially (We will be using named routes, routes stored in routes.dart)
      getPages: getPages,
    );
  }
}
