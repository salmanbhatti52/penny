// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:penny_places/core/constants/constants_colors.dart';
import 'package:penny_places/presentation/auth/sign_in_screen.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  void navigateToSignIn() {
    // Navigate to the sign-in screen. Replace 'SignInScreen()' with your actual sign-in screen widget.
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: ConstantsColors.blueColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: ConstantsColors.blueColor,
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: false,
                    totalRepeatCount: 2,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Penny’s Places",
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    onTap: () {},
                    onFinished:
                        navigateToSignIn, // Navigate after text animation
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
