import 'package:autilab_project/common/widgets/bottomnavigation_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/features/data/auth/presentetion/page/edit_profile_screen.dart';
import 'package:autilab_project/features/data/auth/presentetion/page/send_email_code_screen.dart';
import 'package:autilab_project/features/data/auth/presentetion/page/send_email_screen.dart';
import 'package:autilab_project/features/data/auth/presentetion/page/signup_screen.dart';
// import 'package:autilab_project/features/data/community/page/community_screen.dart';
import 'package:autilab_project/features/data/community/page/doctor_socialmedia_screen.dart';
import 'package:autilab_project/features/data/doctor/presentation/page/doctor_info_screen.dart';
import 'package:autilab_project/features/data/doctor/presentation/page/doctor_speciality_screen.dart';
import 'package:autilab_project/features/data/doctor/presentation/page/doctor_work_schedule_screen.dart';
import 'package:autilab_project/features/data/doctor/presentation/page/make_appointment_screen.dart';
import 'package:autilab_project/features/data/doctor/presentation/page/nearby_center_details_screen.dart';
import 'package:autilab_project/features/data/home/presentation/page/all_appointment_screen.dart';
import 'package:autilab_project/features/data/home/presentation/page/detail_appointment_screen.dart';
import 'package:autilab_project/features/data/home/presentation/page/home_screen.dart';
import 'package:autilab_project/features/data/menu/Page/about_screen.dart';
import 'package:autilab_project/features/data/menu/Page/my_favorite_screen.dart';
import 'package:autilab_project/features/data/menu/Page/mydoctor_screen.dart';
import 'package:autilab_project/features/data/menu/Page/rating_screen.dart';
import 'package:autilab_project/features/data/menu/Page/successful_submit_rate_screen.dart';
import 'package:autilab_project/features/data/menu/Page/testdescription.dart';
import 'package:autilab_project/features/data/message/page/message_screen.dart';
import 'package:autilab_project/features/data/notification/page/notification_screen.dart';
import 'package:autilab_project/features/data/payment/page/not_successful_payment_screen.dart';
import 'package:autilab_project/features/data/payment/page/pay_package_screen.dart';
import 'package:autilab_project/features/data/payment/page/payment_method_screen.dart';
import 'package:autilab_project/features/data/payment/page/personal_detail_payment_screen.dart';
import 'package:autilab_project/features/data/payment/page/successful_payment_screen.dart';
import 'package:autilab_project/features/data/menu/Page/my_subscribtion_screen.dart';
import 'package:autilab_project/features/data/menu/Page/test_history_screen.dart';
import 'package:autilab_project/features/data/menu/Page/user_message_screen.dart';
import 'package:autilab_project/features/data/tool/page/article_item_screen.dart';
import 'package:autilab_project/features/data/tool/page/main_content_screen.dart';
import 'package:autilab_project/features/data/tool/page/tools_screen.dart';
import 'package:autilab_project/features/data/test/presentation/page/aptitude_test_screen.dart';
import 'package:autilab_project/features/data/test/presentation/page/quiz_multiselect_screen.dart';
import 'package:autilab_project/features/data/tool/page/typetest.dart';
import 'package:autilab_project/features/data/tool/page/whiteboard_screen.dart';
import 'package:autilab_project/presentation/screens/choserole_screen.dart';
import 'package:autilab_project/presentation/screens/item_not_found_screen.dart';
import 'package:autilab_project/presentation/screens/not_connection_screen.dart';
import 'package:autilab_project/presentation/screens/program_introduction.dart';
import 'package:autilab_project/presentation/screens/splash_screen.dart';
import 'package:autilab_project/presentation/screens/under_construction_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/data/auth/presentetion/page/login_screen.dart';
import '../../features/data/doctor/presentation/page/doctor_screen.dart';
import '../../features/data/menu/widgets/packagessubscribtion.dart';
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
      // StatefulShellRoute.indexedStack(
      //   branches: [
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: '/homeScreen',
      //           name: AutiLabRoutes.homeScreen,
      //           builder: (context, state) => const HomeScreen(),
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: '/doctorScreen',
      //           name: AutiLabRoutes.doctorScreen,
      //           builder: (context, state) => const DoctorScreen(),
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: '/toolsScreen',
      //           name: AutiLabRoutes.toolsScreen,
      //           builder: (context, state) => const ToolsScreen(),
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: '/profileScreen',
      //           name: AutiLabRoutes.profileScreen,
      //           builder: (context, state) => const EditProfileScreen(),
      //         ),
      //       ],
      //     ),
      //   ],
      //   builder: (BuildContext context, GoRouterState state,
      //       StatefulNavigationShell navigationShell) {
      //     return ButtomnavigationWidget(navigationShell: navigationShell);
      //   },
      // ),
      GoRoute(
        path: '/bottomNavigationScreen',
        name: AutiLabRoutes.bottomNavigationScreen,
        builder: (context, state) => const ButtomnavigationWidget(),
        routes: [
          GoRoute(
            path: 'homeScreen',
            name: AutiLabRoutes.homeScreen,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: 'doctorScreen',
            name: AutiLabRoutes.doctorScreen,
            builder: (context, state) => const DoctorScreen(),
          ),
          GoRoute(
            path: 'toolsScreen',
            name: AutiLabRoutes.toolsScreen,
            builder: (context, state) => const ToolsScreen(),
          ),
          GoRoute(
            path: 'profileScreen',
            name: AutiLabRoutes.profileScreen,
            builder: (context, state) => const EditProfileScreen(),
          ),
        ],
      ),

      GoRoute(
        path: '/doctorSpecialityScreen',
        name: AutiLabRoutes.doctorSpecialityScreen,
        builder: (context, state) {
          final Map<String, dynamic> extraData =
              state.extra as Map<String, dynamic>;
          return DoctorSpecialityScreen(
            doctorList: extraData['doctorList'],
          );
        },
      ),
      GoRoute(
        path: '/allAppointmentScreen',
        name: AutiLabRoutes.allAppointmentScreen,
        builder: (context, state) => const AllAppointmentScreen(),
      ),
      GoRoute(
        path: '/articleItemScreen',
        name: AutiLabRoutes.articleItemScreen,
        builder: (context, state) => const ArticleItemScreen(),
        routes: [
          GoRoute(
            path: '/mainContentScreen',
            name: AutiLabRoutes.mainContentScreen,
            builder: (context, state) {
              final Map<String, dynamic> extraData =
                  state.extra as Map<String, dynamic>;
              return MainContentScreen(
                articleImage: extraData['articleImage'],
                articleTitle: extraData['articleTitle'],
                articleDescription: extraData['articleDescription'],
                articleText: extraData['articleText'],
                isLike: extraData['isLike'],
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/whiteBoardScreen',
        name: AutiLabRoutes.whiteBoardScreen,
        builder: (context, state) => const WhiteboardScreen(),
      ),
      GoRoute(
        path: '/typeTestsScreen',
        name: AutiLabRoutes.typeTestsScreen,
        builder: (context, state) => const TypetestScreen(),
      ),
      GoRoute(
        path: '/nearbyCenterDetailScreen',
        name: AutiLabRoutes.nearbyCenterDetailScreen,
        builder: (context, state) {
          final Map<String, dynamic> extraData =
              state.extra as Map<String, dynamic>;
          return NearbyCenterDetailsScreen(
            isLike: extraData['isLike'] ?? false,
            centerModel: extraData['centerModel'],
          );
        },
      ),
      GoRoute(
        path: '/myFavoriteScreen',
        name: AutiLabRoutes.myFavoriteScreen,
        builder: (context, state) => const MyFavoriteScreen(),
      ),
      GoRoute(
          path: '/detailAppointmentScreen',
          name: AutiLabRoutes.detailAppointmentScreen,
          builder: (context, state) {
            final extraData = state.extra as Map<String, dynamic>;
            return DetailAppointmentScreen(
              doctorModel: extraData['doctorModel'],
              newappointmentModel: extraData['newappointmentModel'],
              statusColor: extraData['statusColor'],
              statusIcon: extraData['statusIcon'],
              image: extraData['image'],
              title: extraData['title'],
              descriptionStatus: extraData['descriptionStatus'],
              dateTimeSchedule: extraData['dateTimeSchedule'],
            );
          }),
      GoRoute(
        path: '/Program_Introduction',
        name: AutiLabRoutes.programIntroductionScreen,
        builder: (context, state) => const ProgramIntroductionScreen(),
      ),
      GoRoute(
        path: '/choseRoleScreen',
        name: AutiLabRoutes.choseRoleScreen,
        builder: (context, state) => const ChoseRoleScreen(),
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
          builder: (context, state) {
            final Map<String, dynamic> extraData =
                state.extra as Map<String, dynamic>;
            return SendEmailCodeScreen(
              email: extraData['email'],
            );
          }),
      GoRoute(
        path: '/send_email',
        name: AutiLabRoutes.sendEmailScreen,
        builder: (context, state) => const SendEmailScreen(),
      ),
      GoRoute(
        path: '/doctorMessageScreen',
        name: AutiLabRoutes.doctorMessageScreen,
        builder: (context, state) {
          final Map<String, dynamic> extraData =
              state.extra as Map<String, dynamic>;

          return MessageScreen(
            image: extraData['image'],
            name: extraData['name'],
            expertise: extraData['expertise'],
          );
        },
      ),
      GoRoute(
          path: '/makeAppointmentScreen',
          name: AutiLabRoutes.makeAppointmentScreen,
          builder: (context, state) {
            final Map<String, dynamic> extraData =
                state.extra as Map<String, dynamic>;
            return MakeAppointmentScreen(
              isLike: extraData['isLike'],
              user: extraData['doctorUser'],
              specialty: extraData['specialty'],
            );
          }),
      GoRoute(
          path: '/doctorInformationScreen',
          name: AutiLabRoutes.doctorInformationScreen,
          builder: (context, state) {
            final Map<String, dynamic> extraData =
                state.extra as Map<String, dynamic>;
            return DoctorInfoScreen(
              isLike: extraData['isLike'] ?? false,
              user: extraData['doctorUser'],
              doctorSpecialities: extraData['doctorSpecialities'],
            );
          }),
      GoRoute(
        path: '/doctorSocialMediaScreen',
        name: AutiLabRoutes.doctorSocialMediaScreen,
        builder: (context, state) => const DoctorSocialMediaScreen(),
      ),
      GoRoute(
          path: '/doctorWorkscheduleScreen',
          name: AutiLabRoutes.doctorWorkscheduleScreen,
          builder: (context, state) {
            final Map<String, dynamic> extraData =
                state.extra as Map<String, dynamic>;
            return DoctorWorkScheduleScreen(
              isLike: extraData['isLike'] ?? false,
              doctorUser: extraData['doctorUser'],
              specialty: extraData['specialty'],
            );
          }),
      GoRoute(
        path: '/editProfileScreen',
        name: AutiLabRoutes.editProfileScreen,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/messageProfileScreen',
        name: AutiLabRoutes.messageProfileScreen,
        builder: (context, state) => const UserMessageScreen(),
      ),
      GoRoute(
        path: '/subscribtionScreen',
        name: AutiLabRoutes.subscribtionScreen,
        builder: (context, state) => const MySubscribtionScreen(),
        routes: [
          GoRoute(
              path: 'subscribtionPackagesScreen',
              name: AutiLabRoutes.subscribtionPackagesScreen,
              builder: (context, state) {
                final Map<String, dynamic> extraData =
                    state.extra as Map<String, dynamic>;
                return PackagesSubscribtion(
                  planDescription: extraData['planFeuture'],
                  planModel: extraData['planModel'],
                );
              }),
        ],
      ),
      GoRoute(
        path: '/notificationScreen',
        name: AutiLabRoutes.notificationScreen,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: '/testHistoryScreen',
        name: AutiLabRoutes.testHistoryScreen,
        builder: (context, state) => const TestHistoryScreen(),
        routes: [
          GoRoute(
            path: '/testDescriptionScreen',
            name: AutiLabRoutes.testDescriptionScreen,
            builder: (context, state) {
              final Map<String, dynamic> extraData =
                  state.extra as Map<String, dynamic>;
              return TestdescriptionResult(
                description: extraData['description'],
              );
            },
          ),
        ],
      ),
      GoRoute(
          path: '/notConnectionScreen',
          name: AutiLabRoutes.notConnectionScreen,
          builder: (context, state) {
            final Map<String, dynamic> extraData =
                state.extra as Map<String, dynamic>;
            return NotConnectionInternetScreen(
              onChange: extraData['extraData'],
            );
          }),
      GoRoute(
        path: '/itemNotFoundScreen',
        name: AutiLabRoutes.itemNotFoundScreen,
        builder: (context, state) => const ItemNotFoundScreen(),
      ),
      GoRoute(
        path: '/underConstructionScreen',
        name: AutiLabRoutes.underConstructionScreen,
        builder: (context, state) => const UnderConstructionScreen(),
      ),
      GoRoute(
        path: '/successfulPaymentScreen',
        name: AutiLabRoutes.successfulPaymentScreen,
        builder: (context, state) => const SuccessfulPaymentScreen(),
      ),
      GoRoute(
        path: '/notSuccessfulPaymentScreen',
        name: AutiLabRoutes.notSuccessfulPaymentScreen,
        builder: (context, state) => const NotSuccessfulPaymentScreen(),
      ),
      GoRoute(
        path: '/payPackagesScreen',
        name: AutiLabRoutes.payPackagesScreen,
        builder: (context, state) {
          final Map<String, dynamic> extraData =
              state.extra as Map<String, dynamic>;
          return PayPackageScreen(
            title: extraData['title'],
            description: extraData['description'],
            planDescription: extraData['planDescription'],
            planModel: extraData['planModel'],
            options: extraData['options'],
            price: extraData['price'],
          );
        },
      ),
      GoRoute(
        path: '/personalDetailPaymentScreen',
        name: AutiLabRoutes.personalDetailPaymentScreen,
        builder: (context, state) {
          final Map<String, dynamic> extraData =
              state.extra as Map<String, dynamic>;
          return PersonalDetailPaymentScreen(
            planModel: extraData['planModel'],
          );
        },
      ),
      GoRoute(
        path: '/paymentMethodScreen',
        name: AutiLabRoutes.paymentMethodScreen,
        builder: (context, state) => const PaymentMethodScreen(),
      ),
      GoRoute(
        path: '/aptitudeTestScreen',
        name: AutiLabRoutes.aptitudeTestScreen,
        builder: (context, state) {
          final Map<String, dynamic> extraData =
              state.extra as Map<String, dynamic>;
          return AptitudeTestScreen(
            image: extraData['image'],
            title: extraData['title'],
            subTitle: extraData['subTitle'],
            description: extraData['description'],
            onTap: extraData['onTap'],
          );
        },
        routes: [
          GoRoute(
            path: 'quizMultiSelectScreen',
            name: AutiLabRoutes.quizMultiSelectScreen,
            builder: (context, state) => const QuizAndSelectAnswerScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/myDoctorScreen',
        name: AutiLabRoutes.myDoctorScreen,
        builder: (context, state) => const MydoctorScreen(),
        routes: [
          GoRoute(
            path: 'ratingScreen',
            name: AutiLabRoutes.ratingScreen,
            builder: (context, state) => const RatingScreen(),
          ),
          GoRoute(
            path: 'successfulSubmitRateScreen',
            name: AutiLabRoutes.successfulSubmitRateScreen,
            builder: (context, state) => const SuccessfulSubmitRateScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/aboutScreen',
        name: AutiLabRoutes.aboutScreen,
        builder: (context, state) => const AboutScreen(),
      ),
    ],
  );
}
