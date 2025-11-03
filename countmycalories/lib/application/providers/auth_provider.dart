import 'package:flutter/foundation.dart';
import 'package:countmycalories/application/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService;
  bool _isLoading = false;

  AuthProvider({required this.authService});

  bool get isLoading => _isLoading;
  bool get isLoggedIn => authService.isLoggedIn;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final success = await authService.login(email, password);
    _isLoading = false;
    notifyListeners();
    return success;
  }

  void logout() {
    authService.logout();
    notifyListeners();
  }
}


