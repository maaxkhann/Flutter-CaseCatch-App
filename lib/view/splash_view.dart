import 'dart:async';
import 'package:catch_case/view/intro-view/intro_view1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () => Get.off(() => const IntroView1()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Image.asset(
        'assets/images/logo.png',
        width: double.infinity,
        height: Get.height * 1,
        fit: BoxFit.fill,
      )),
    ));
  }
}
