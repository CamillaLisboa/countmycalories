import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:countmycalories/application/providers/auth_provider.dart';
import 'package:countmycalories/application/providers/meal_provider.dart';
import 'package:countmycalories/application/providers/profile_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:countmycalories/core/constants/app_routes.dart';
import 'package:countmycalories/core/constants/app_strings.dart';
import 'package:countmycalories/core/constants/app_colors.dart';
import 'package:countmycalories/core/constants/app_images.dart';

class HomeViewAndroid extends StatefulWidget {
  const HomeViewAndroid({super.key});

  @override
  State<HomeViewAndroid> createState() => _HomeViewAndroidState();
}

class _HomeViewAndroidState extends State<HomeViewAndroid> {
  bool _monthly = false;

  @override
  Widget build(BuildContext context) {
    final mealProvider = context.watch<MealProvider>();
    final profile = context.watch<ProfileProvider>().profile;
    final today = DateTime.now();
    final totalToday = mealProvider.totalForDate(today);
    final last3 = mealProvider.mealsForDate(today).take(3).toList();
    final remaining = profile.dailyCalorieTarget - totalToday;
    final double percent = profile.dailyCalorieTarget > 0
        ? ((totalToday / profile.dailyCalorieTarget).clamp(0.0, 1.0)).toDouble()
        : 0.0;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Meu consumo',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        IconButton(onPressed: () => context.go(AppRoutes.settings), icon: const Icon(Icons.settings)),
                        IconButton(onPressed: () => context.go(AppRoutes.dashboard), icon: const Icon(Icons.dashboard)),
                        IconButton(
                          onPressed: () {
                            context.read<AuthProvider>().logout();
                            context.go(AppRoutes.login);
                          },
                          icon: const Icon(Icons.logout),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _monthly = false),
                          child: Text(
                            'Hoje',
                            style: TextStyle(
                              decoration: !_monthly ? TextDecoration.underline : TextDecoration.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('/'),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => setState(() => _monthly = true),
                          child: Text(
                            'Mensal',
                            style: TextStyle(
                              decoration: _monthly ? TextDecoration.underline : TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (!_monthly) ...[
                      Text('${(percent * 100).round()}% das calorias totais', style: const TextStyle(color: AppColors.textGray)),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Container(height: 16, color: const Color(0xFFFDE9D2)),
                            FractionallySizedBox(
                              widthFactor: percent,
                              child: Container(height: 16, color: AppColors.accentOrange),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...last3.map((e) => _MealTile(title: e.name, calories: e.calories)).toList(),
                    ] else ...[
                      Text('${(percent * 100).round()}% das calorias totais', style: const TextStyle(color: AppColors.textGray)),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Container(height: 16, color: const Color(0xFFFDE9D2)),
                            FractionallySizedBox(
                              widthFactor: percent,
                              child: Container(height: 16, color: AppColors.accentOrange),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _MonthlyBars(mealProvider: mealProvider),
                    ],
                    const SizedBox(height: 24),
                    Center(child: Image.asset(AppImages.logo, width: 80, height: 80)),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: InkWell(
                  onTap: () => context.go(AppRoutes.addMeal),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary,
                    child: const Icon(Icons.add, color: Colors.white, size: 28),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MealTile extends StatelessWidget {
  final String title;
  final int calories;
  const _MealTile({required this.title, required this.calories});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFD6D6D6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 18, backgroundColor: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                Text('$calories calorias', style: const TextStyle(color: AppColors.textGray, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthlyBars extends StatelessWidget {
  final MealProvider mealProvider;
  const _MonthlyBars({required this.mealProvider});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final List<DateTime> months = List.generate(5, (i) {
      final d = DateTime(now.year, now.month - (4 - i), 1);
      return DateTime(d.year, d.month, 1);
    });
    final from = DateTime(months.first.year, months.first.month, 1);
    final to = DateTime(months.last.year, months.last.month + 1, 0);
    final byDay = mealProvider.totalsByDay(from: from, to: to);
    final Map<int, int> monthTotals = {};
    byDay.forEach((date, calories) {
      final key = date.year * 100 + date.month;
      monthTotals[key] = (monthTotals[key] ?? 0) + calories;
    });
    final labels = const ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'];
    final values = months
        .map((m) => monthTotals[m.year * 100 + m.month] ?? 0)
        .toList();
    final maxVal = (values.isEmpty ? 0 : values.reduce((a, b) => a > b ? a : b)).toDouble();
    final scale = maxVal > 0 ? 120.0 / maxVal : 0.0;

    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < months.length; i++)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 28,
                    height: (values[i] * scale).clamp(0.0, 120.0),
                    color: Colors.black54,
                  ),
                  const SizedBox(height: 6),
                  Text(labels[months[i].month - 1]),
                ],
              ),
          ],
        ),
      ],
    );
  }
}


