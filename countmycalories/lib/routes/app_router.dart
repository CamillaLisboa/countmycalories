import 'package:go_router/go_router.dart';
import 'package:flutter/widgets.dart';
import 'package:countmycalories/core/constants/app_routes.dart';
import 'package:countmycalories/pages/login/login_page.dart';
import 'package:countmycalories/pages/home/home_page.dart';
import 'package:countmycalories/application/providers/auth_provider.dart';
import 'package:countmycalories/pages/signup/signup_page.dart';
import 'package:countmycalories/pages/settings/settings_page.dart';
import 'package:countmycalories/pages/meals/add_meal_page.dart';
import 'package:countmycalories/pages/dashboard/dashboard_page.dart';

GoRouter createRouter(AuthProvider authProvider) {
  return GoRouter(
    refreshListenable: authProvider,
    initialLocation: AppRoutes.login,
    redirect: (ctx, state) {
      final isLoggedIn = authProvider.isLoggedIn;
      final atAuthPages = state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.signup;
      if (!isLoggedIn && !atAuthPages) return AppRoutes.login;
      if (isLoggedIn && atAuthPages) return AppRoutes.home;
      return null;
    },
    routes: <GoRoute>[
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.addMeal,
        builder: (context, state) => const AddMealPage(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );
}


