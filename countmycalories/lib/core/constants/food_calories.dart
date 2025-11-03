// kcal per gram for common foods (approximate values)
class FoodCalories {
  static const Map<String, double> kcalPerGram = <String, double>{
    'Arroz': 1.30, // 130 kcal per 100g
    'Feijão': 1.27, // 127 kcal per 100g
    'Frango': 1.65, // 165 kcal per 100g (peito cozido)
    'Salada': 0.20, // 20 kcal per 100g (média)
    'Ovo': 1.55, // 155 kcal per 100g
    'Iogurte': 0.60, // 60 kcal per 100g
  };

  static double? perGram(String foodName) {
    return kcalPerGram[foodName];
  }
}


