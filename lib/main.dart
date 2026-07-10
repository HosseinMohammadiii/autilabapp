import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/core/network/locator.dart';
import 'package:autilab_project/core/network/shared_preferences.dart';
import 'package:autilab_project/core/routes/routes.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_bloc.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_event.dart';
import 'package:autilab_project/features/data/doctor/presentation/bloc/center/center_bloc.dart';
import 'package:autilab_project/features/data/doctor/presentation/bloc/doctor/doctor_bloc.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_bloc.dart';
import 'package:autilab_project/features/data/test/presentation/bloc/test_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesData.init();
  await getInInit();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => AuthenticationBloc(
        //     locator.get(),
        //   ),
        // ),
        // BlocProvider(
        //   create: (_) =>
        //       AuthenticationBloc(locator.get())..add(DisplayInformationUser()),
        // ),
        BlocProvider(
          create: (_) => ProfileBlocLocal(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(
            locator.get(),
          ),
        ),
        BlocProvider(
          create: (context) => DoctorBloc(
            locator.get(),
          ),
        ),
        BlocProvider(
          create: (context) => CenterBloc(
            locator.get(),
          ),
        ),
        BlocProvider(
          create: (context) => TestBloc(
            locator.get(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
          child: child!,
        );
      },
    );
  }
}
