class UserProfile {
  final String id;
  final double heightCm;
  final double weightKg;
  final int dailyCalorieTarget;

  const UserProfile({
    required this.id,
    required this.heightCm,
    required this.weightKg,
    required this.dailyCalorieTarget,
  });

  UserProfile copyWith({
    double? heightCm,
    double? weightKg,
    int? dailyCalorieTarget,
  }) {
    return UserProfile(
      id: id,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      dailyCalorieTarget: dailyCalorieTarget ?? this.dailyCalorieTarget,
    );
  }
}


