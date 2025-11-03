import 'package:get_it/get_it.dart';
import 'package:countmycalories/application/services/auth_service.dart';
import 'package:countmycalories/application/services/profile_service.dart';
import 'package:countmycalories/application/services/meal_service.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  if (serviceLocator.isRegistered<AuthService>()) return;
  serviceLocator.registerLazySingleton<AuthService>(() => AuthService());
  serviceLocator.registerLazySingleton<ProfileService>(() => ProfileService());
  serviceLocator.registerLazySingleton<MealService>(() => MealService());
}


