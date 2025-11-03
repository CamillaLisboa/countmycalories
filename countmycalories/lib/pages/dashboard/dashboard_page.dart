import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:countmycalories/application/providers/meal_provider.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final monthStart = DateTime(now.year, now.month, 1);
    final totalsToday = context.watch<MealProvider>().totalForDate(now);
    final byDayWeek = context.watch<MealProvider>().totalsByDay(from: weekStart, to: now);
    final byDayMonth = context.watch<MealProvider>().totalsByDay(from: monthStart, to: now);
    final df = DateFormat('dd/MM');

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hoje: $totalsToday kcal', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              Text('Semana', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              _TotalsList(totals: byDayWeek, df: df),
              const SizedBox(height: 16),
              Text('Mês', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              _TotalsList(totals: byDayMonth, df: df),
            ],
          ),
        ),
      ),
    );
  }
}

class _TotalsList extends StatelessWidget {
  final Map<DateTime, int> totals;
  final DateFormat df;
  const _TotalsList({required this.totals, required this.df});

  @override
  Widget build(BuildContext context) {
    final entries = totals.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    if (entries.isEmpty) {
      return const Text('Sem dados ainda.');
    }
    return Column(
      children: entries
          .map((e) => ListTile(
                dense: true,
                title: Text(df.format(e.key)),
                trailing: Text('${e.value} kcal'),
              ))
          .toList(),
    );
  }
}


