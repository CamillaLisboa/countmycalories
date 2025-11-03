import 'package:flutter/material.dart';
import 'package:countmycalories/core/platform/platform_detector.dart';
import 'package:countmycalories/pages/signup/views/signup_view_android.dart';
import 'package:countmycalories/pages/signup/views/signup_view_web.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (PlatformDetector.isWeb) return const SignupViewWeb();
    return const SignupViewAndroid();
  }
}


