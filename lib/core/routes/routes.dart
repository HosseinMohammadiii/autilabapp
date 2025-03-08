import 'package:autilab_project/common/widgets/bottomnavigation_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/features/data/auth/page/send_email_code_screen.dart';
import 'package:autilab_project/features/data/auth/page/send_email_screen.dart';
import 'package:autilab_project/features/data/auth/page/signup_screen.dart';
import 'package:autilab_project/features/data/community/page/community_screen.dart';
import 'package:autilab_project/features/data/community/page/doctor_socialmedia_screen.dart';
import 'package:autilab_project/features/data/doctor/page/doctor_info_screen.dart';
import 'package:autilab_project/features/data/doctor/page/doctor_work_schedule_screen.dart';
import 'package:autilab_project/features/data/home/page/home_screen.dart';
import 'package:autilab_project/features/data/message/page/message_screen.dart';
import 'package:autilab_project/features/data/tool/page/tools_screen.dart';
import 'package:autilab_project/presentation/screens/program_introduction.dart';
import 'package:autilab_project/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/data/auth/page/login_screen.dart';
import '../../features/data/doctor/page/doctor_screen.dart';
import '../../presentation/screens/welcome_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AutilabRouter {
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/doctorScreen',
    routes: [
      GoRoute(
        path: '/',
        name: AutiLabRoutes.initialScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/doctorScreen',
                name: AutiLabRoutes.doctorScreen,
                builder: (context, state) => const DoctorScreen(),
                routes: [
                  GoRoute(
                    path: 'doctorInformationScreen',
                    name: AutiLabRoutes.doctorInformationScreen,
                    builder: (context, state) => const DoctorInfoScreen(),
                  ),
                  GoRoute(
                    path: 'doctorSocialMediaScreen',
                    name: AutiLabRoutes.doctorSocialMediaScreen,
                    builder: (context, state) =>
                        const DoctorSocialMediaScreen(),
                  ),
                  GoRoute(
                    path: 'doctorWorkscheduleScreen',
                    name: AutiLabRoutes.doctorWorkscheduleScreen,
                    builder: (context, state) =>
                        const DoctorWorkScheduleScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/homeScreen',
                name: AutiLabRoutes.homeScreen,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/toolsScreen',
                name: AutiLabRoutes.toolsScreen,
                builder: (context, state) => const ToolsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/communityScreen',
                name: AutiLabRoutes.communityScreen,
                builder: (context, state) => const CommunityScreen(),
              ),
            ],
          ),
        ],
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return ButtomnavigationWidget(navigationShell: navigationShell);
        },
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
            path: 'login',
            name: AutiLabRoutes.loginScreen,
            builder: (context, state) => const LogInScreen(),
          ),
          GoRoute(
            path: 'signUp',
            name: AutiLabRoutes.signUpScreen,
            builder: (context, state) => const SignupScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/send_email_code',
        name: AutiLabRoutes.sendEmailCodeScreen,
        builder: (context, state) => const SendEmailCodeScreen(),
      ),
      GoRoute(
        path: '/send_email',
        name: AutiLabRoutes.sendEmailScreen,
        builder: (context, state) => const SendEmailScreen(),
      ),
      GoRoute(
        path: '/doctorMessageScreen',
        name: AutiLabRoutes.doctorMessageScreen,
        builder: (context, state) => const MessageScreen(),
      ),
    ],
  );
}
