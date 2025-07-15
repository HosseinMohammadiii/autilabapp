import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/core/network/locator.dart';
import 'package:autilab_project/core/network/shared_preferences.dart';
import 'package:autilab_project/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesData.init();
  await getInInit();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AutilabTheme.theme,
      routerConfig: AutilabRouter.router,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child!);
      },
    );
  }
}
