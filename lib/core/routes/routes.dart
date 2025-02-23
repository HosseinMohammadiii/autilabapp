import 'package:autilab_project/common/widgets/buttomnavigation_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/features/data/auth/page/send_email_code_screen.dart';
import 'package:autilab_project/features/data/auth/page/send_email_screen.dart';
import 'package:autilab_project/features/data/auth/page/signup_screen.dart';
import 'package:autilab_project/presentation/screens/program_introduction.dart';
import 'package:autilab_project/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/data/auth/page/login_screen.dart';
import '../../presentation/screens/welcome_screen.dart';

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
      GoRoute(
        path: '/Program_Introduction',
        name: AutiLabRoutes.programIntroductionScreen,
        builder: (context, state) => const ProgramIntroductionScreen(),
      ),
      GoRoute(
        path: '/welcome',
        name: AutiLabRoutes.welcomeScreen,
        builder: (context, state) => const WelcomeScreen(),
        routes: [
          GoRoute(
            path: '/login',
            name: AutiLabRoutes.loginScreen,
            builder: (context, state) => const LogInScreen(),
          ),
          GoRoute(
            path: '/signUp',
            name: AutiLabRoutes.signUpScreen,
            builder: (context, state) => const SignupScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/send_email_code',
        name: AutiLabRoutes.sendEmailCodeScreen,
        builder: (context, state) {
          return const SendEmailCodeScreen();
        },
      ),
      GoRoute(
        path: '/send_email',
        name: AutiLabRoutes.sendEmailScreen,
        builder: (context, state) {
          return const SendEmailScreen();
        },
      ),
      GoRoute(
        path: '/buttomNavigationScreen',
        name: AutiLabRoutes.buttomNavigationScreen,
        builder: (context, state) {
          return const ButtomnavigationWidget();
        },
      ),
    ],
  );
}
