import 'package:countmycalories/domain/entities/user_profile.dart';

class ProfileService {
  UserProfile? _profile;

  UserProfile getOrCreateDefault(String userId) {
    _profile ??= UserProfile(
      id: userId,
      heightCm: 170,
      weightKg: 70,
      dailyCalorieTarget: 2000,
    );
    return _profile!;
  }

  UserProfile updateProfile({
    required double heightCm,
    required double weightKg,
    required int dailyCalorieTarget,
  }) {
    if (_profile == null) {
      _profile = UserProfile(
        id: 'default',
        heightCm: heightCm,
        weightKg: weightKg,
        dailyCalorieTarget: dailyCalorieTarget,
      );
    } else {
      _profile = _profile!.copyWith(
        heightCm: heightCm,
        weightKg: weightKg,
        dailyCalorieTarget: dailyCalorieTarget,
      );
    }
    return _profile!;
  }
}


