import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constant_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _splash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              'assets/icons/autilab_logo.svg',
              colorFilter: const ColorFilter.mode(
                Color(0xff81BFDA),
                BlendMode.srcIn,
              ),
              width: 300,
            ),
            const Center(
              child: CircularProgressIndicator(
                color: Color(0xff81BFDA),
              ),
            ),
          ],
        ),
      ),
    );
  }

//Method to create a delay and go to the page logIn
  Future<void> _splash() async {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        //Go to the logIn Screen
        context.goNamed(AutiLabRoutes.loginScreen);
      },
    );
  }
}
