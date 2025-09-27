import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/constant/app_images.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.go(root);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(splashColor),
      body: Center(
        child: AnimatedOpacity(
          curve: Curves.easeIn,
          duration: const Duration(seconds: 2),
          opacity: _opacity,
          child: Image.asset(AppImages.imagesOnboardingSplash),
        ),
      ),
    );
  }
}
