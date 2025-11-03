import 'package:flutter/foundation.dart';
import 'package:countmycalories/application/services/meal_service.dart';
import 'package:countmycalories/domain/entities/meal_entry.dart';

class MealProvider extends ChangeNotifier {
  final MealService mealService;

  MealProvider({required this.mealService});

  List<MealEntry> mealsForDate(DateTime date) => mealService.mealsForDate(date);
  int totalForDate(DateTime date) => mealService.totalCaloriesForDate(date);
  int estimateForName(String name) => mealService.estimateCaloriesForName(name);

  void addMeal({required DateTime dateTime, required String name, required int calories}) {
    mealService.addMeal(dateTime: dateTime, name: name, calories: calories);
    notifyListeners();
  }

  Map<DateTime, int> totalsByDay({required DateTime from, required DateTime to}) =>
      mealService.totalsByDay(from: from, to: to);
}


