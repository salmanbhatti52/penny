import 'dart:async';

import 'package:flutter/material.dart';
import 'package:penny_places/core/constants/constants_colors.dart';
import 'package:penny_places/main.dart';
import 'package:penny_places/presentation/widgets/custom_text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      appBloc.checkOnboardingStatus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: ConstantsColors.blueColor,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextWidget(
                  text: "Penny’s Places",
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
