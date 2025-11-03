class AuthService {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _isLoggedIn = email.isNotEmpty && password.isNotEmpty;
    return _isLoggedIn;
  }

  void logout() {
    _isLoggedIn = false;
  }
}


