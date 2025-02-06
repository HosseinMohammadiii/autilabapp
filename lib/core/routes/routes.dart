import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AutilabRouter {
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AutiLabRoutes.initialScreen,
        builder: (context, state) => const SplashScreen(),
      ),
    ],
  );
}
