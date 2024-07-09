import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/store.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/utils/constants.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  DateTime? _expiryDate;
  Timer? _logoutTimer;

  String? get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  // 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${Constants.API_KEY}';
  // 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${Constants.API_KEY}';
  Future<void> _authenticate(
      String email, String password, String _urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:${_urlSegment}?key=${Constants.API_KEY}';
    final Uri uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final responseBody = json.decode(response.body);
    print('response: $responseBody');
    if (responseBody["error"] != null) {
      throw AuthException(responseBody['error']['message']);
    } else {
      _token = responseBody['idToken'];
      _userId = responseBody['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseBody['expiresIn'],
          ),
        ),
      );
      Store.saveMap('userData', {
        "token": _token,
        "userId": _userId,
        "expiryDate": _expiryDate?.toIso8601String(),
      });
      _autoLogout();
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) {
      return Future.value();
    }
    final userData = await Store.getMap("userData");
    if (userData == null) {
      return Future.value();
    }
    final expiryDate = DateTime.parse(userData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return Future.value();
    }

    _userId = userData['userId'];
    _token = userData['token'];
    _expiryDate = expiryDate;
    _autoLogout();
    notifyListeners();
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_logoutTimer != null) {
      _logoutTimer?.cancel();
      _logoutTimer = null;
    }
    Store.remove('userData');
    notifyListeners();
  }

  void _autoLogout() {
    if (_logoutTimer != null) {
      _logoutTimer?.cancel();
    }
    final timeToLogout = _expiryDate?.difference(DateTime.now()).inSeconds ?? 0;
    _logoutTimer = Timer(Duration(seconds: timeToLogout), logout);
  }
}
