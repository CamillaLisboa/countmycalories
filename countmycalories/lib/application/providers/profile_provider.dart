import 'package:flutter/foundation.dart';
import 'package:countmycalories/application/services/profile_service.dart';
import 'package:countmycalories/domain/entities/user_profile.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService profileService;
  late UserProfile _profile;

  ProfileProvider({required this.profileService}) {
    _profile = profileService.getOrCreateDefault('default');
  }

  UserProfile get profile => _profile;

  void update({required double heightCm, required double weightKg, required int dailyTarget}) {
    _profile = profileService.updateProfile(
      heightCm: heightCm,
      weightKg: weightKg,
      dailyCalorieTarget: dailyTarget,
    );
    notifyListeners();
  }
}


