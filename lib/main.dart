import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/init/navigation/navigation_routes.dart';
import 'package:spark_auth_demo/core/init/theme/app_theme_manager.dart';
import 'core/init/navigation/navigation_service.dart';

void main() async {
  await init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeManager.instance.lightTheme,
      darkTheme: AppThemeManager.instance.darkTheme,
      themeMode: ThemeMode.system,
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
    );
  }
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}
