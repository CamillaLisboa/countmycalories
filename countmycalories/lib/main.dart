import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:countmycalories/core/di/service_locator.dart';
import 'package:countmycalories/application/services/auth_service.dart';
import 'package:countmycalories/application/providers/auth_provider.dart';
import 'package:countmycalories/application/providers/profile_provider.dart';
import 'package:countmycalories/application/providers/meal_provider.dart';
import 'package:countmycalories/core/constants/app_colors.dart';
import 'package:countmycalories/core/constants/app_strings.dart';
import 'package:countmycalories/routes/app_router.dart';

void main() {
  setupServiceLocator();
  final authProvider = AuthProvider(
    authService: serviceLocator<AuthService>(),
  );
  final profileProvider = ProfileProvider(
    profileService: serviceLocator(),
  );
  final mealProvider = MealProvider(
    mealService: serviceLocator(),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
        ChangeNotifierProvider<ProfileProvider>.value(value: profileProvider),
        ChangeNotifierProvider<MealProvider>.value(value: mealProvider),
      ],
      child: App(authProvider: authProvider),
    ),
  );
}

class App extends StatefulWidget {
  final AuthProvider authProvider;
  const App({super.key, required this.authProvider});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router = createRouter(widget.authProvider);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
