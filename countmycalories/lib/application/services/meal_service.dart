import 'dart:collection';
import 'package:countmycalories/domain/entities/meal_entry.dart';

class MealService {
  final List<MealEntry> _entries = <MealEntry>[];

  UnmodifiableListView<MealEntry> get allEntries => UnmodifiableListView(_entries);

  void addMeal({required DateTime dateTime, required String name, required int calories}) {
    _entries.add(MealEntry(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      dateTime: dateTime,
      name: name.trim(),
      calories: calories,
    ));
  }

  List<MealEntry> mealsForDate(DateTime date) {
    return _entries.where((e) => _isSameDate(e.dateTime, date)).toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  int totalCaloriesForDate(DateTime date) {
    return mealsForDate(date).fold<int>(0, (sum, e) => sum + e.calories);
  }

  int estimateCaloriesForName(String name) {
    final same = _entries.where((e) => e.name.toLowerCase() == name.toLowerCase());
    if (same.isEmpty) return 0;
    final avg = same.fold<int>(0, (sum, e) => sum + e.calories) / same.length;
    return avg.round();
  }

  Map<DateTime, int> totalsByDay({required DateTime from, required DateTime to}) {
    final Map<DateTime, int> totals = {};
    for (final e in _entries) {
      if (e.dateTime.isBefore(from) || e.dateTime.isAfter(to)) continue;
      final day = DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day);
      totals[day] = (totals[day] ?? 0) + e.calories;
    }
    return totals;
  }

  static bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}


