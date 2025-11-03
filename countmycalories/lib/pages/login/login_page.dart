import 'package:flutter/material.dart';
import 'package:countmycalories/core/platform/platform_detector.dart';
import 'package:countmycalories/pages/login/views/login_view_android.dart';
import 'package:countmycalories/pages/login/views/login_view_web.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (PlatformDetector.isWeb) return const LoginViewWeb();
    return const LoginViewAndroid();
  }
}


