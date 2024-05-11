import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/config/services/contracts/environment.dart';
import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Locator();
  await getIt<Environment>().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
