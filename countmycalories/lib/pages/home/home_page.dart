import 'package:flutter/material.dart';
import 'package:countmycalories/core/platform/platform_detector.dart';
import 'package:countmycalories/pages/home/views/home_view_android.dart';
import 'package:countmycalories/pages/home/views/home_view_web.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (PlatformDetector.isWeb) return const HomeViewWeb();
    return const HomeViewAndroid();
  }
}


