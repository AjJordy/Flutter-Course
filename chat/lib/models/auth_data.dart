import 'dart:io';

enum AuthMode { login, singup }

class AuthData {
  String? name;
  String? email;
  String? password;
  File? image;
  AuthMode _mode = AuthMode.login;

  bool get isSingup {
    return _mode == AuthMode.login;
  }

  bool get isLogin {
    return _mode == AuthMode.singup;
  }

  void toggleMode() {
    _mode = _mode == AuthMode.login ? AuthMode.singup : AuthMode.login;
  }
}
